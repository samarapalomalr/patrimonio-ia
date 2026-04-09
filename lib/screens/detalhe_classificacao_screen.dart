import 'package:flutter/material.dart';
import '../models/classificacao_model.dart';

class DetalheClassificacaoScreen extends StatelessWidget {
  final ClassificacaoModel classificacao;

  const DetalheClassificacaoScreen({
    super.key,
    required this.classificacao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(classificacao.nome),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 IMAGEM (ANTES ERA TEXTO)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                classificacao.exemplo,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,

                // 👇 ajuda se der erro de asset
                errorBuilder: (_, __, ___) {
                  return Container(
                    height: 220,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text("Erro ao carregar imagem"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Text(
              classificacao.nome,
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 16),

            Text(
              classificacao.descricao,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 28),

            const Text(
              "Exemplo de aplicação",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            // 🔥 opcional: repetir imagem menor abaixo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                classificacao.exemplo,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
