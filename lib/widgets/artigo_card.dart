import 'package:flutter/material.dart';
import '../models/artigo_model.dart';
import 'artigo_resumo_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtigoCard extends StatelessWidget {
  final ArtigoModel artigo;

  const ArtigoCard({super.key, required this.artigo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              artigo.titulo,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Autores
            Text(
              artigo.autores.join(', '),
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
            ),

            const SizedBox(height: 6),

            // Ano
            Text('Ano: ${artigo.ano}', style: const TextStyle(fontSize: 12)),

            const SizedBox(height: 10),

            // Palavras-chave
            Wrap(
              spacing: 6,
              runSpacing: -8,
              children: artigo.palavrasChave.map((keyword) {
                return Chip(
                  label: Text(keyword, style: const TextStyle(fontSize: 11)),
                  backgroundColor: Colors.blue.shade50,
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  icon: const Icon(Icons.article_outlined),
                  label: const Text('Ler resumo'),
                  onPressed: () {
                    showArtigoResumo(context, artigo);
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Acessar'),
                  onPressed: () async {
                    final uri = Uri.parse(artigo.linkExterno);
                    if (await canLaunchUrl(uri)) {
                      launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
