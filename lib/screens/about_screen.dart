import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/artigo_model.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final Set<String> favoritos = {};
  final Set<String> expandido = {};

  List<ArtigoModel> get artigos => [
        ArtigoModel(
          id: '1',
          titulo:
              "A deep learning approach for cultural heritage building classification using transfer learning and data augmentation",
          autores: [
            "André Luiz Carvalho Ottoni",
            "Lara Toledo Cordeiro Ottoni"
          ],
          ano: 2025,
          palavrasChave: [
            "Artificial Intelligence",
            "Deep Learning",
            "Computer Vision",
            "Cultural Heritage",
            "Transfer Learning",
            "Data Augmentation",
            "Image Classification",
            "MobileNet"
          ],
          resumo:
              "Este estudo propõe uma abordagem baseada em deep learning para a classificação de componentes arquitetônicos em edifícios históricos, com foco na preservação do patrimônio cultural. Foi desenvolvido o dataset ImageMG, contendo 6.449 imagens de 94 construções históricas localizadas em cidades de Minas Gerais, Brasil, organizadas em cinco categorias: frontão, igreja, porta, janela e torre.\n\nO trabalho investiga o impacto do uso de transfer learning aliado a técnicas de data augmentation, analisando 64 combinações diferentes de transformações geométricas, como rotação, zoom e espelhamento. Os experimentos foram realizados com a arquitetura MobileNet, demonstrando que a combinação de transfer learning com augmentation otimizado melhora significativamente o desempenho do modelo.\n\nOs melhores resultados alcançaram 92,37% de acurácia na validação, evidenciando o potencial da inteligência artificial aplicada à arquitetura colonial brasileira e contribuindo para processos de documentação digital e conservação do patrimônio histórico.",
          linkExterno:
              "https://www.sciencedirect.com/science/article/abs/pii/S1296207425001207",
        ),
        ArtigoModel(
          id: '2',
          titulo:
              "ImageOP: The Image Dataset with Religious Buildings in the World Heritage Town of Ouro Preto for Deep Learning Classification",
          autores: [
            "André Luiz Carvalho Ottoni",
            "Lara Toledo Cordeiro Ottoni"
          ],
          ano: 2022,
          palavrasChave: [
            "Deep Learning",
            "Computer Vision",
            "Cultural Heritage",
            "Dataset",
            "Image Classification",
            "MobileNetV2",
            "EfficientNet",
            "Edge Impulse"
          ],
          resumo:
              "Este trabalho apresenta o ImageOP, um dataset desenvolvido para classificação de edifícios religiosos na cidade histórica de Ouro Preto, Minas Gerais — reconhecida como Patrimônio Mundial pela UNESCO. O conjunto de dados contém 1.613 imagens de fachadas de 32 monumentos religiosos, organizadas em cinco categorias: frontão, porta, janela, torre e igreja.\n\nO estudo busca suprir a carência de datasets voltados à arquitetura colonial brasileira no contexto de visão computacional. Para validação, foram realizados experimentos em duas etapas: simulações computacionais e testes em dispositivos móveis utilizando técnicas de visão computacional em tempo real.\n\nForam avaliadas duas arquiteturas de deep learning, MobileNetV2 e EfficientNetB0, utilizando a plataforma Edge Impulse, com foco em baixo custo computacional e aplicações em smartphones. Os resultados demonstraram alto desempenho, com destaque para a EfficientNet, que atingiu 94,5% de acurácia, além de elevados valores de precisão, recall e F-score.\n\nOs testes em dispositivos móveis confirmaram a eficácia do dataset, alcançando aproximadamente 88% de acurácia em aplicações reais, reforçando seu potencial para uso em sistemas de documentação e preservação do patrimônio cultural.",
          linkExterno: "https://www.mdpi.com/2571-9408/7/11/302",
        ),
        ArtigoModel(
          id: '3',
          titulo:
              "Inteligência Artificial para a Classificação de Elementos Arquitetônicos em Construções Históricas: Um Estudo de Caso na Cidade de Raposos/MG",
          autores: [
            "Samara Paloma Lopes Augusto Ribeiro",
            "André Luiz Carvalho Ottoni",
          ],
          ano: 2025,
          palavrasChave: [
            "Patrimônio Cultural",
            "Inventário",
            "Visão Computacional",
            "Deep Learning",
            "MobileNetV2",
            "Edge Impulse",
            "Multidisciplinaridade"
          ],
          resumo:
              "Este trabalho investiga o uso de inteligência artificial para a classificação automática de elementos arquitetônicos em construções históricas, com foco na preservação do patrimônio cultural. O estudo destaca a importância do inventário como instrumento fundamental para a proteção, registro e gestão de bens culturais.\n\nA abordagem utiliza técnicas de visão computacional e aprendizado profundo, com aplicação do modelo MobileNetV2 para identificação de elementos como portas, janelas e outros componentes arquitetônicos. O treinamento foi realizado com imagens do dataset ImageOP, composto por edificações históricas da cidade de Ouro Preto/MG.\n\nComo diferencial, o trabalho realiza uma avaliação com imagens inéditas da cidade de Raposos/MG, analisando a capacidade de generalização do modelo em um novo contexto urbano. A implementação foi conduzida na plataforma Edge Impulse, permitindo testes em cenários práticos e com baixo custo computacional.\n\nOs resultados demonstram o potencial da inteligência artificial como ferramenta de apoio à documentação, conservação e digitalização do patrimônio histórico, contribuindo para aplicações multidisciplinares envolvendo tecnologia e cultura.",
          linkExterno: "COLE_AQUI_O_LINK_DO_ARTIGO_3",
        ),
        ArtigoModel(
          id: '4',
          titulo:
              "A Computer Vision Approach to Heritage Window Classification using a Novel Dataset and CNN Selection for Mobile Devices",
          autores: [
            "André Luiz Carvalho Ottoni",
            "Lara Toledo Cordeiro Ottoni"
          ],
          ano: 2024,
          palavrasChave: [
            "Artificial Intelligence",
            "Computer Vision",
            "Cultural Heritage",
            "Deep Learning",
            "MobileNet",
            "Dataset",
            "Image Classification",
            "Smartphone"
          ],
          resumo:
              "Este trabalho apresenta uma abordagem de visão computacional para classificação de janelas históricas, com foco na preservação do patrimônio cultural e aplicação em dispositivos móveis.\n\nFoi desenvolvido o dataset HW-Data (Heritage Window Dataset), contendo 1.197 imagens de alta resolução, organizadas em quatro categorias de janelas comuns em edificações históricas brasileiras: sacada, guilhotina, almofada e calha.\n\nA metodologia foi dividida em duas etapas: ajuste fino do modelo MobileNet e testes em ambiente real utilizando smartphone. Entre as configurações avaliadas, a MobileNetV2 160×160 0.35 apresentou o melhor desempenho.\n\nOs resultados alcançaram F1-score de 94% na validação e 96,1% de acurácia em testes realizados em seis edifícios históricos na cidade de Santa Bárbara/MG, demonstrando alta eficiência e viabilidade para aplicações práticas em campo.",
          linkExterno: "COLE_AQUI_O_LINK_DO_ARTIGO_4",
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final artigosFiltrados = artigos;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saiba Mais"),
        backgroundColor: const Color.fromARGB(255, 129, 24, 3),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: artigosFiltrados.length,
        itemBuilder: (context, index) {
          return _buildArtigoCard(artigosFiltrados[index]);
        },
      ),
    );
  }

  Widget _buildArtigoCard(ArtigoModel artigo) {
    final isFavorito = favoritos.contains(artigo.id);
    final isExpandido = expandido.contains(artigo.id);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: isExpandido ? 8 : 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      artigo.titulo,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorito ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorito
                            ? favoritos.remove(artigo.id)
                            : favoritos.add(artigo.id);
                      });
                    },
                  )
                ],
              ),

              const SizedBox(height: 6),

              Text(
                artigo.autores.join(', '),
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),

              const SizedBox(height: 6),

              Text(
                'Ano: ${artigo.ano}',
                style: const TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 10),

              // 🔥 CHIPS SOMENTE VISUAIS
              Wrap(
                spacing: 6,
                children: artigo.palavrasChave.map((k) {
                  return Chip(
                    label: Text(k),
                    backgroundColor: Colors.orange[100],
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              const Text(
                "Resumo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: isExpandido
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Text(
                  artigo.resumo,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                secondChild: Text(
                  artigo.resumo,
                  textAlign: TextAlign.justify,
                ),
              ),

              TextButton(
                child: Text(isExpandido ? "Ver menos" : "Ver mais"),
                onPressed: () {
                  setState(() {
                    isExpandido
                        ? expandido.remove(artigo.id)
                        : expandido.add(artigo.id);
                  });
                },
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Resumo copiado!")),
                      );
                    },
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text("Abrir artigo"),
                    onPressed: () => _abrirLink(artigo.linkExterno),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _abrirLink(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Não foi possível abrir o link")),
      );
    }
  }
}
