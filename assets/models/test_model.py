import tensorflow as tf
import numpy as np
import cv2
import os

# 🔧 Força backend gráfico estável
os.environ["QT_QPA_PLATFORM"] = "xcb"
import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "arquitetura_5classes.tflite")
IMG_SIZE = 96

# 🔴 COLOQUE AS LABELS NA ORDEM CORRETA
LABELS = [
    "Torre",
    "Porta",
    "Janela",
    "Igreja",
    "Frontao"
]

# ===== LOAD MODEL =====
interpreter = tf.lite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

print("✅ Modelo carregado")

# ===== OPEN CAMERA =====
cap = cv2.VideoCapture(0, cv2.CAP_V4L2)
if not cap.isOpened():
    raise RuntimeError("❌ Não foi possível abrir a câmera")

cv2.namedWindow("Classificação Arquitetônica", cv2.WINDOW_NORMAL)

print("📷 Câmera ligada — pressione 'q' para sair")

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # ===== PREPROCESS (Edge Impulse INT8) =====
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
    probs = scale * (output - zero_point)

    class_id = int(np.argmax(probs))
    confidence = float(probs[class_id])

    label = LABELS[class_id] if class_id < len(LABELS) else "Desconhecido"

    # ===== DISPLAY =====
    text = f"{label} ({confidence:.2f})"
    cv2.putText(
        frame, text, (20, 40),
        cv2.FONT_HERSHEY_SIMPLEX, 1,
        (0, 255, 0), 2
    )

    cv2.imshow("Classificação Arquitetônica", frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

# ===== CLEANUP =====
cap.release()
cv2.destroyAllWindows()



