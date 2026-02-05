class ArtigoModel {
  final String id;
  final String titulo;
  final List<String> autores;
  final int ano;
  final List<String> palavrasChave;
  final String resumo;
  final String linkExterno;

  ArtigoModel({
    required this.id,
    required this.titulo,
    required this.autores,
    required this.ano,
    required this.palavrasChave,
    required this.resumo,
    required this.linkExterno,
  });

  factory ArtigoModel.fromMap(String id, Map<String, dynamic> map) {
    return ArtigoModel(
      id: id,
      titulo: map['titulo'],
      autores: List<String>.from(map['autores']),
      ano: map['ano'],
      palavrasChave: List<String>.from(map['palavras_chave']),
      resumo: map['resumo'],
      linkExterno: map['link_externo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autores': autores,
      'ano': ano,
      'palavras_chave': palavrasChave,
      'resumo': resumo,
      'link_externo': linkExterno,
    };
  }
}
