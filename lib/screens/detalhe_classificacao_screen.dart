import 'package:flutter/material.dart';
import '../models/classificacao_model.dart';

class DetalheClassificacaoScreen extends StatelessWidget {
  final ClassificacaoModel classificacao;

  const DetalheClassificacaoScreen({super.key, required this.classificacao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(classificacao.nome)),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              classificacao.exemplo,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
