class ModelRegistry {
  /// 📦 Caminho dos modelos
  static const Map<String, String> models = {
    'Elementos Arquitetônicos': 'assets/models/arquitetura_5elementos.tflite',

    'Casa Corrente': 'assets/models/casas_coloniais.tflite',

    // ✅ NOVO MODELO (JANELAS)
    'Janelas Históricas': 'assets/models/janelas_heritage.tflite',
  };

  /// ⚠️ ORDEM IDÊNTICA AO TREINAMENTO (Edge Impulse)
  static const Map<String, List<String>> labels = {
    'Elementos Arquitetônicos': [
      'Church',
      'Door',
      'Fronton',
      'Tower',
      'Window',
    ],

    'Casa Corrente': [
      "Casa de Meia Morada",
      "Casas de Porta e Janela",
      "Sobrado de Frente Estreita",
    ],

    // ✅ EXTRAÍDO DIRETAMENTE DO SEU MODELO C++
    'Janelas Históricas': [
      "BalconyDoor-PortaSacada",
      "PanelledWindow-Almofada",
      "PlainWindow-Calha",
      "SashWindow-Guilhotina",
    ],
  };

  /// 📏 INPUT SIZE (IMPORTANTE PARA RESIZE)
  static const Map<String, int> inputSizes = {
    'Elementos Arquitetônicos': 96,
    'Casa Corrente': 96,

    // ✅ MESMO DO EDGE IMPULSE (input_width = 96)
    'Janelas Históricas': 96,
  };
}
