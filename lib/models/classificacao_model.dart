class ClassificacaoModel {
  final String nome;
  final String descricao;
  final String exemplo;

  ClassificacaoModel({
    required this.nome,
    required this.descricao,
    required this.exemplo,
  });
}

final List<ClassificacaoModel> classificacoes = [
  ClassificacaoModel(
    nome: 'Porta',
    descricao:
        'Elemento arquitetônico que permite acesso ou passagem entre ambientes.',
    exemplo:
        'Portas coloniais costumam ser de madeira maciça com detalhes entalhados.',
  ),
  ClassificacaoModel(
    nome: 'Janela',
    descricao: 'Abertura em paredes para iluminação e ventilação natural.',
    exemplo: 'Janelas históricas geralmente possuem caixilhos de madeira.',
  ),
  ClassificacaoModel(
    nome: 'Igreja',
    descricao: 'Edificação religiosa destinada à realização de cultos.',
    exemplo: 'Igrejas barrocas são comuns em cidades históricas.',
  ),
  ClassificacaoModel(
    nome: 'Frontão',
    descricao: 'Elemento decorativo localizado acima da fachada.',
    exemplo: 'Frontões triangulares são típicos do barroco.',
  ),
  ClassificacaoModel(
    nome: 'Torre',
    descricao: 'Estrutura vertical elevada, geralmente associada a igrejas.',
    exemplo: 'Torres costumam abrigar sinos.',
  ),
];
