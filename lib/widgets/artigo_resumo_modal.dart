import 'package:flutter/material.dart';
import '../models/artigo_model.dart';

void showArtigoResumo(BuildContext context, ArtigoModel artigo) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Text(
                artigo.titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                artigo.resumo,
                style: const TextStyle(fontSize: 14, height: 1.5),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}
