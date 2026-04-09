import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Sobre"),
          _buildInfoCard(),
          const SizedBox(height: 20),
          _buildSectionTitle("Informações legais"),
          _buildOptionTile(
            context,
            icon: Icons.description,
            title: "Termos de uso",
            page: const TermosScreen(),
          ),
          _buildOptionTile(
            context,
            icon: Icons.privacy_tip,
            title: "Política de privacidade",
            page: const PrivacidadeScreen(),
          ),
          const SizedBox(height: 10),
          _buildSectionTitle("Suporte"),
          _buildOptionTile(
            context,
            icon: Icons.support_agent,
            title: "Ajuda e Suporte",
            page: const SuporteScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Sobre o aplicativo\n\n"
          "Este aplicativo foi desenvolvido no contexto de um projeto de Iniciação Científica da Universidade Federal de Ouro Preto (UFOP), "
          "com apoio do programa PIBITI/CNPq (2025–2026). A proposta central é aplicar técnicas de Inteligência Artificial para auxiliar na "
          "identificação e classificação de elementos construtivos em edificações históricas.\n\n"
          "A solução utiliza modelos de aprendizado profundo e visão computacional para reconhecer componentes arquitetônicos treinados na plataforma Edge Impulse, contribuindo "
          "para processos de documentação, preservação e valorização do patrimônio cultural.\n\n"
          "Além do desenvolvimento tecnológico, o projeto integra conhecimentos de diferentes áreas, promovendo a conexão entre pesquisa acadêmica "
          "e soluções inovadoras voltadas ao patrimônio histórico.\n\n"
          "Autores\n\n"
          "Samara Paloma Lopes Augusto Ribeiro\n"
          "Graduanda em Ciência da Computação (UFOP) e integrante do grupo de pesquisa MLBots – Machine Learning and Robotics (CNPq).\n"
          "Contato: samara.augusto@aluno.ufop.edu.br\n\n"
          "André Luiz Carvalho Ottoni\n"
          "Professor do Departamento de Computação (DECOM/UFOP) e líder do grupo de pesquisa MLBots.\n"
          "Contato: andre.ottoni@ufop.edu.br",
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context,
      {required IconData icon, required String title, required Widget page}) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}

// ================= TERMOS =================
class TermosScreen extends StatelessWidget {
  const TermosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Termos de Uso")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            "Ao utilizar este aplicativo, você concorda com os seguintes termos:\n\n"
            "1. Uso do Aplicativo\n"
            "Este aplicativo tem finalidade acadêmica e educacional.\n\n"
            "2. Responsabilidades\n"
            "O usuário é responsável pelo uso adequado das informações.\n\n"
            "3. Propriedade Intelectual\n"
            "Todo o conteúdo pertence aos autores do projeto.\n\n"
            "4. Limitações\n"
            "Não garantimos precisão total dos resultados da IA.\n\n"
            "5. Alterações\n"
            "Os termos podem ser atualizados sem aviso prévio.",
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}

// ================= PRIVACIDADE =================
class PrivacidadeScreen extends StatelessWidget {
  const PrivacidadeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Política de Privacidade")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            "Sua privacidade é importante para nós.\n\n"
            "1. Coleta de Dados\n"
            "Podemos coletar nome e e-mail para autenticação.\n\n"
            "2. Uso das Informações\n"
            "Os dados são usados apenas para funcionamento do app.\n\n"
            "3. Compartilhamento\n"
            "Não compartilhamos seus dados com terceiros.\n\n"
            "4. Segurança\n"
            "Adotamos medidas para proteger suas informações.\n\n"
            "5. Direitos\n"
            "Você pode solicitar exclusão dos seus dados.",
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}

// ================= SUPORTE =================
class SuporteScreen extends StatelessWidget {
  const SuporteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajuda e Suporte")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "Precisa de ajuda?\n\n"
          "Entre em contato:\n\n"
          "Email: samarapaloma57@gmail.com\n\n"
          "Ou consulte a documentação do projeto.\n\n"
          "Este aplicativo foi desenvolvido como projeto acadêmico.",
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
