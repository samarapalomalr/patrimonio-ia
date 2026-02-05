import 'package:flutter/material.dart';
import '../models/classificacao_model.dart';
import 'detalhe_classificacao_screen.dart';

class DuvidasScreen extends StatelessWidget {
  const DuvidasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final classificacoes = [
      ClassificacaoModel(
        nome: "Elementos Arquitetônicos",
        descricao: "Identificação automática de componentes arquitetônicos "
            "presentes em edificações históricas.",
        exemplo: "Portas, janelas, torres, igrejas e frontões.",
      ),

      ClassificacaoModel(
        nome: "Rachaduras",
        descricao:
            "Análise visual de fissuras e trincas em estruturas históricas.",
        exemplo: "Rachaduras em paredes, colunas e fachadas.",
      ),

      // ✅ NOVA CLASSIFICAÇÃO
      ClassificacaoModel(
        nome: "Casa Corrente",
        descricao: "Classificação arquitetônica de edificações residenciais "
            "históricas de tipologia simples, comuns em centros urbanos "
            "tradicionais.",
        exemplo: "Casas térreas ou sobrados simples, alinhados à via pública, "
            "com fachada contínua e poucos elementos ornamentais.",
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Classificações • Dúvidas")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: classificacoes.length,
        itemBuilder: (context, index) {
          final item = classificacoes[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.orange),
              title: Text(
                item.nome,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(item.descricao),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetalheClassificacaoScreen(classificacao: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
