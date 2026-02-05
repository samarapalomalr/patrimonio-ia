import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// 🔹 FirebaseAuth só existe em Web / Android / iOS
  bool get _hasFirebase {
    return kIsWeb ||
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _hasFirebase ? FirebaseAuth.instance.currentUser : null;

    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // ================= PERFIL =================
          ListTile(
            leading: const CircleAvatar(
              radius: 26,
              child: Icon(Icons.person, size: 30),
            ),
            title: Text(user?.displayName ?? "Usuário"),
            subtitle: Text(user?.email ?? ""),
          ),

          const Divider(),

          // ================= SOBRE =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Sobre",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Este aplicativo é resultado de um Projeto de Iniciação Científica "
              "vinculado ao PROPP/UFOP EDITAL 03/2025 – PIBITI/CNPq (2025–2026).\n\n"
              "Título do projeto:\n"
              "Desenvolvimento de sistema inteligente para classificação de "
              "elementos construtivos em edificações históricas.\n\n"
              "Objetivo geral:\n"
              "Desenvolver um protótipo de sistema inteligente para classificação "
              "de elementos construtivos em edificações históricas.\n\n"
              "Objetivos específicos:\n"
              "• Estudo de conceitos de Inteligência Artificial, Aprendizado de "
              "Máquina, Engenharia de Software e construções históricas.\n"
              "• Aplicação de técnicas de aprendizado profundo para classificação "
              "de elementos construtivos.\n"
              "• Desenvolvimento da interface gráfica e integração com modelos "
              "de aprendizado profundo.",
              textAlign: TextAlign.justify,
            ),
          ),

          const SizedBox(height: 16),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Desenvolvedores",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Samara Paloma Lopes Augusto Ribeiro\n"
              "Estudante de graduação em Ciência da Computação (7º período) na "
              "Universidade Federal de Ouro Preto (UFOP). Membro do grupo de "
              "pesquisa MLBots – Machine Learning and Robotics (CNPq). Atuou como "
              "pesquisadora voluntária no projeto Robótica e Inteligência "
              "Artificial na Construção 4.0 (288h). Interesses de pesquisa: "
              "Inteligência Artificial, Aprendizado de Máquina e Engenharia de "
              "Software.\n"
              "E-mail: samara.augusto@aluno.ufop.edu.br\n\n"
              "André Luiz Carvalho Ottoni\n"
              "Professor adjunto do Departamento de Computação (DECOM) da UFOP. "
              "Doutor em Engenharia Elétrica (UFBA). Líder do grupo de pesquisa "
              "MLBots. Docente permanente do PPGCC/UFOP e do PPGEEC/UFRB. Atua "
              "nas áreas de Inteligência Artificial, Aprendizado Profundo, "
              "Aprendizado por Reforço, AutoML e Robótica Inteligente.\n"
              "E-mail: andre.ottoni@ufop.edu.br",
              textAlign: TextAlign.justify,
            ),
          ),

          const Divider(),

          // ================= TERMOS =================
          ListTile(
            title: const Text("Termos de uso"),
            onTap: () {},
          ),

          // ================= PRIVACIDADE =================
          ListTile(
            title: const Text("Política de privacidade"),
            onTap: () {},
          ),

          const Divider(),

          // ================= SUPORTE =================
          ListTile(
            title: const Text("Ajuda e Suporte"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
