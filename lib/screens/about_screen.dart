import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/artigo_model.dart'; // contém ArtigoModel

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  List<ArtigoModel> get artigos => [
    ArtigoModel(
      id: '1',
      titulo:
          "A deep learning approach for cultural heritage building classification using transfer learning and data augmentation",
      autores: ["André Luiz Carvalho Ottoni", "Lara Toledo Cordeiro Ottoni"],
      ano: 2023,
      palavrasChave: [
        "Artificial Intelligence",
        "Cultural Heritage",
        "Deep Learning",
        "Transfer Learning",
        "Data Augmentation",
      ],
      resumo:
          "This study proposes a deep learning approach for cultural heritage building classification using transfer learning and data augmentation. The ImageMG dataset is introduced, containing 6,449 images of 94 historic buildings from Minas Gerais (Brazil). The approach evaluates the influence of transfer learning and data augmentation, achieving up to 92.37% accuracy in validation.",
      linkExterno: "COLE_AQUI_O_LINK_DO_ARTIGO_1",
    ),
    ArtigoModel(
      id: '2',
      titulo:
          "ImageOP: The Image Dataset with Religious Buildings in the World Heritage Town of Ouro Preto for Deep Learning Classification",
      autores: ["André Luiz Carvalho Ottoni", "Lara Toledo Cordeiro Ottoni"],
      ano: 2022,
      palavrasChave: [
        "Deep Learning",
        "Cultural Heritage",
        "Dataset",
        "Image Classification",
        "Computer Vision",
      ],
      resumo:
          "This paper presents ImageOP, a dataset composed of 1,613 images of religious buildings in Ouro Preto, Brazil. The dataset was evaluated using MobileNetV2 and EfficientNetB0, achieving up to 94.5% accuracy in simulations and strong results in real-time smartphone experiments.",
      linkExterno: "COLE_AQUI_O_LINK_DO_ARTIGO_2",
    ),
    ArtigoModel(
      id: '3',
      titulo:
          "Inteligência Artificial para a Classificação de Elementos Arquitetônicos em Construções Históricas: Um Estudo de Caso na Cidade de Raposos/MG",
      autores: [
        "Samara Paloma Lopes Augusto Ribeiro",
        "André Luiz Carvalho Ottoni",
      ],
      ano: 2024,
      palavrasChave: [
        "Patrimônio Cultural",
        "Deep Learning",
        "Reconhecimento de Imagens",
        "Inventário",
        "Multidisciplinaridade",
      ],
      resumo:
          "Este trabalho apresenta uma abordagem inovadora para a identificação automática de elementos arquitetônicos em bens históricos, utilizando aprendizado profundo. O modelo MobileNetV2 foi treinado com o conjunto ImageOP e testado com imagens da cidade de Raposos/MG, demonstrando boa capacidade de generalização.",
      linkExterno: "COLE_AQUI_O_LINK_DO_ARTIGO_3",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saiba Mais"),
        backgroundColor: const Color(0xFFB05126),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: artigos.length,
        itemBuilder: (context, index) {
          return _buildArtigoCard(artigos[index]);
        },
      ),
    );
  }

  Widget _buildArtigoCard(ArtigoModel artigo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artigo.titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            Wrap(
              spacing: 6,
              runSpacing: -8,
              children: artigo.palavrasChave
                  .map(
                    (k) => Chip(
                      label: Text(k),
                      backgroundColor: Colors.orange[100],
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            const Text("Resumo", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(artigo.resumo, textAlign: TextAlign.justify),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: const Icon(Icons.open_in_new),
                label: const Text("Abrir artigo"),
                onPressed: () => _abrirLink(artigo.linkExterno),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
