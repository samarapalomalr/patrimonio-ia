import tensorflow as tf
import numpy as np
import cv2
import os

# Evita erro gráfico no Linux
os.environ["QT_QPA_PLATFORM"] = "xcb"

# ==============================
# PATH DO MODELO
# ==============================

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "casas_coloniais.tflite")

IMG_SIZE = 96
CONFIDENCE_THRESHOLD = 0.6

# ==============================
# CLASSES
# ==============================

LABELS = [
    "Casa de Meia Morada",
    "Casas de Porta e Janela",
    "Sobrado de Frente Estreita"
]

# ==============================
# LOAD MODEL
# ==============================

interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

print("✅ Modelo carregado")

# ==============================
# CÂMERA
# ==============================

cap = cv2.VideoCapture(0)

if not cap.isOpened():
    raise RuntimeError("❌ Não foi possível abrir a câmera")

cv2.namedWindow("Classificação Casas Coloniais", cv2.WINDOW_NORMAL)

print("📷 Câmera ligada — pressione 'q' para sair")

# ==============================
# LOOP
# ==============================

while True:

    ret, frame = cap.read()

    if not ret:
        break

    # ===== PREPROCESS =====

    img = cv2.resize(frame, (IMG_SIZE, IMG_SIZE))
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    img = img.astype(np.int16) - 128
    img = np.clip(img, -128, 127).astype(np.int8)

    img = np.expand_dims(img, axis=0)

    # ===== INFERENCE =====

    interpreter.set_tensor(input_details[0]["index"], img)
    interpreter.invoke()

    output = interpreter.get_tensor(output_details[0]["index"])[0]

    # ===== DEQUANTIZE =====

    scale, zero_point = output_details[0]["quantization"]
    probs = (output.astype(np.float32) - zero_point) * scale

    class_id = np.argmax(probs)
    confidence = probs[class_id]

    # ===== CLASSIFICATION =====

    if confidence < CONFIDENCE_THRESHOLD:
        label = "Nenhuma categoria"
        color = (0, 0, 255)
    else:
        label = LABELS[class_id]
        color = (0, 255, 0)

    # ===== DISPLAY =====

    text = f"{label} ({confidence:.2f})"

    cv2.putText(
        frame,
        text,
        (20, 40),
        cv2.FONT_HERSHEY_SIMPLEX,
        1,
        color,
        2
    )

    cv2.imshow("Classificação Casas Coloniais", frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

# ==============================
# FINALIZA
# ==============================

cap.release()
cv2.destroyAllWindows()