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
              "Uma abordagem de aprendizado profundo para a classificação de edificações de patrimônio cultural utilizando aprendizado por transferência e aumento de dados",
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
              "ImageOP: Conjunto de dados de imagens de edificações religiosas na cidade de Ouro Preto para classificação por aprendizado profundo",
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
          linkExterno: "https://www.patrimonioculturalbrasil.org/anais/iisndpc",
        ),
        ArtigoModel(
          id: '4',
          titulo:
              "Uma Abordagem de Visão Computacional para a Classificação de Janelas de Patrimônio Histórico utilizando um Novo Conjunto de Dados e Seleção de CNN para Dispositivos Móveis",
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
        ArtigoModel(
          id: '5',
          titulo:
              "Aprendizagem profunda para detecção de crack em patrimônios culturais: uma revisão sistemática",
          autores: [
            "André Luiz Carvalho Ottoni",
            "Lara Toledo Cordeiro Ottoni",
          ],
          ano: 2026,
          palavrasChave: [
            "Inteligência Artificial",
            "Patrimônio Cultural",
            "Crack",
            "Aprendizagem Profunda",
            "Aprendizado de Máquina",
          ],
          resumo:
              "Rachaduras são um defeito crítico a ser identificado durante inspeções de patrimônios culturais. Neste contexto, vários estudos recentes têm explorado técnicas de Inteligência Artificial (IA) para detecção de crack em estruturas históricas. No entanto, a literatura ainda carece de uma revisão bibliográfica estruturada sobre o estado da arte neste campo de pesquisa. Portanto, o objetivo deste trabalho é apresentar uma revisão sistemática da literatura sobre aprendizagem profunda para detecção de crack no patrimônio cultural. Foram analisados 26 artigos, publicados entre 2020 e 2025 e indexados na base de dados Scopus. A metodologia proposta abordou cinco questões de pesquisa, com o objetivo de identificar os artigos mais citados e os periódicos com maior número de publicações, a disponibilidade de conjuntos de dados públicos, os métodos de aprendizagem profunda mais utilizados, os tipos de monumentos e países estudados e perspectivas de pesquisa futura. As principais descobertas incluem a identificação de seis conjuntos de dados disponíveis ao público contendo imagens para o treinamento de modelos de IA na detecção de crack para patrimônio cultural. Além disso, YOLO surgiu como o método de aprendizagem profunda mais frequentemente adotado neste domínio. A revisão também mostrou que estudos de caso foram realizados em monumentos ou objetos de 12 países diferentes, com vários estudos com foco em Patrimônio Mundial da UNESCO. Por fim, foram identificados sete principais desafios futuros, com o maior destaque: melhorar as capacidades de generalização dos métodos de aprendizagem profunda, melhorar a qualidade e disponibilidade dos conjuntos de dados e avançar no uso de veículos aéreos autônomos em tarefas de inspeção de patrimônio.",
          linkExterno: "https://doi.org/10.1016/j.gloher.2026.100002",
        ),
        ArtigoModel(
          id: '6',
          titulo:
              "Inteligência artificial sustentável para classificação de componentes de edifícios históricos: um caso de patrimônio mundial da UNESCO em Congonhas, Brasil",
          autores: [
            "André Luiz Carvalho Ottoni",
            "Lara Toledo Cordeiro Ottoni",
          ],
          ano: 2025,
          palavrasChave: [
            "Patrimônio cultural",
            "Desenvolvimento sustentável",
            "Inteligência artificial",
            "Visão computacional",
            "UNESCO",
          ],
          resumo:
              "O estudo propõe uma abordagem de inteligência artificial sustentável para a classificação de componentes de edifícios históricos, com foco na redução do consumo de energia dos modelos de aprendizagem profunda. A pesquisa foi aplicada ao Santuário do Bom Jesus, em Congonhas (MG), reconhecido como Patrimônio Mundial da UNESCO. A metodologia envolveu a coleta de fotografias dos edifícios, organização do conjunto de dados, seleção de seis modelos de deep learning, realização de experimentos e avaliação da eficiência energética de cada modelo. Os resultados mostraram que modelos mais leves, como MobileNet e MobileNetV2, apresentam desempenho semelhante ao de modelos mais complexos, porém com menor consumo de energia durante o treinamento.Como principal contribuição, o trabalho demonstra que é possível utilizar modelos de inteligência artificial mais sustentáveis na preservação do patrimônio histórico, reduzindo o impacto energético sem comprometer a precisão da classificação dos componentes arquitetônicos. Além disso, o estudo apresenta uma aplicação inovadora da IA sustentável em um importante patrimônio cultural brasileiro reconhecido pela UNESCO.",
          linkExterno: "https://doi.org/10.1108/JCHMSD-05-2025-0145",
        ),
        ArtigoModel(
          id: '7',
          titulo:
              "Detecção de Elementos em Construções Históricas da Cidade do Serro com Aprendizado Profundo",
          autores: [
            "Lara Toledo Cordeiro Ottoni",
            "André Luiz Carvalho Ottoni",
          ],
          ano: 2025,
          palavrasChave: [
            "Deep Learning",
            "Computer Vision",
            "Cultural Heritage",
            "Image Processing",
            "CNN",
            "Architectural Element Detection",
          ],
          resumo:
              "O patrimônio cultural possui grande importância histórica, arquitetônica e social, sendo essencial para preservar a memória e a identidade de uma sociedade. Este trabalho propõe o uso da inteligência artificial para automatizar a identificação de elementos arquitetônicos em edificações históricas. Para isso, foi desenvolvida uma ferramenta baseada em aprendizado profundo utilizando uma rede neural convolucional (CNN), treinada com a base de dados ImageOP, composta por mais de 1.600 imagens de monumentos de Ouro Preto. Após o treinamento, o modelo foi aplicado em edificações históricas do município do Serro para reconhecer elementos como portas, janelas, torres, frontões e igrejas. Os resultados indicam que a abordagem contribui para a digitalização, o monitoramento e a preservação do patrimônio histórico, além de fornecer suporte para futuras análises de conservação, identificação de patologias e planejamento de restaurações.",
          linkExterno: "http://dx.doi.org/10.21528/CBIC2025-1171947",
        ),
        ArtigoModel(
          id: '8',
          titulo:
              "Aprendizado de Máquina para Avaliação de Danos em Construções Históricas Utilizando Visão Computacional",
          autores: [
            "Lavínia Souza Ferreira",
            "André Luiz Carvalho Ottoni",
          ],
          ano: 2025,
          palavrasChave: [
            "Deep Learning",
            "Damage Classification",
            "Historical Heritage",
            "Artificial Neural Networks",
            "Computer Vision",
          ],
          resumo:
              "A preservação do patrimônio histórico é um desafio crucial, exigindo métodos modernos para a identificação e monitoramento de danos em edificações antigas. O uso de inteligência artificial, especialmente Deep Learning , tem se mostrado uma abordagem promissora para aprimorar a precisão e a eficiência desse processo. No entanto, um dos principais desafios é desenvolver modelos de classificação de danos robustos e confiáveis, considerando a influência de diferentes hiperp arâmetros. Este trabalho tem c omo objetivo avaliar manifestações patológicas em portas e janelas de edifícios históricos utilizando técnicas de Deep Learning , analisando o impacto de hiperparâmetros na performance da classificação. A metodologia envolveu a criação e rotulagem de um banco de imagens em quatro categorias: portas com danos, portas sem danos, janelas com danos e janelas sem danos. Foram testadas diferentes arquiteturas de redes neurais, variações na taxa de aprendizado e o uso de Data Augmentation para melhorar a generalização do modelo. Os resultados indicaram que os ajuste da taxa de aprendizado e a aplicação de Data Augmentation obtiveram resultados significativos de acurácia, sendo 67% para portas e 80,0% para janelas. Já com relação à variação das arquiteturas neurais, i nicialmente, foi utilizada a arquitetura MobileNetV2 96×96 0,35 . Nas etapas subsequentes, outras arquiteturas foram selecionadas para comparação como MobileNetV1 96×96 0,1, MobileNetV2 160×160 0,35 e EfficientNet B0. Ao final dos testes, a MobileNetV2 96×96 0,35 trouxe melhores resultados para a classe de portas enquanto para a classe de janelas, a MobileNetV2 160×160 0 ,35 se destacou. Nos testes práticos, utilizando as melhores combinações entre os três hiperparâmetros, os resultados obtidos foram os seguintes: para portas com danos, a acurácia foi de 80,0%; para port as sem danos, foi alcançada uma acurácia de 100%. Em relaçãoàs janelas com danos, obteve-se uma acurácia de 100%, e, por fim, para janelas sem danos, a acurácia foi de 87,5%.",
          linkExterno: "http://dx.doi.org/10.21528/CBIC2025-1144817",
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
