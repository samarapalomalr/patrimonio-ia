class ModelRegistry {
  /// 📦 Caminho dos modelos
  static const Map<String, String> models = {
    'Elementos Arquitetônicos': 'assets/models/arquitetura_5elementos.tflite',

    'Casa Corrente': 'assets/models/casas_coloniais.tflite',

    // ✅ JANELAS
    'Janelas Históricas': 'assets/models/janelas_heritage.tflite',

    // ✅ NOVO: PORTAS (Edge Impulse)
    'Portas': 'assets/models/portas.tflite',
  };

  /// ⚠️ ORDEM IDÊNTICA AO TREINAMENTO
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
    'Janelas Históricas': [
      "BalconyDoor-PortaSacada",
      "PanelledWindow-Almofada",
      "PlainWindow-Calha",
      "SashWindow-Guilhotina",
    ],
    'Portas': [
      "1 - Panelled Door (Almofada)",
      "2 - Plain Door (Calha)",
    ],
  };

  /// 📏 INPUT SIZE (CRÍTICO)
  static const Map<String, int> inputSizes = {
    'Elementos Arquitetônicos': 96,
    'Casa Corrente': 96,
    'Janelas Históricas': 96,

    // ✅ EDGE IMPULSE → 192x192
    'Portas': 192,
  };
}

//
