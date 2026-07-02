import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/session_service.dart';
import 'camera_screen.dart';
import 'history_screen.dart';
import 'about_screen.dart';
import 'login_screen.dart';
import 'map_screen.dart';
import 'duvidas_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _nomeExibicao = "Usuário";

  @override
  void initState() {
    super.initState();
    _buscarNomeUsuario();
  }

  Future<void> _buscarNomeUsuario() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null && firebaseUser.displayName != null) {
      setState(() => _nomeExibicao = firebaseUser.displayName!);
    } else {
      final localUser = await SessionService.getLocalUser();
      if (localUser != null && mounted) {
        setState(() => _nomeExibicao = localUser);
      }
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    await SessionService.clear();

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );
    }
  }

  void _confirmarSair() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text("Sair"),
        content: const Text("Deseja encerrar sua sessão?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCELAR"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _logout();
            },
            child: const Text("SAIR", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _abrirClassificacao() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Escolha o tipo de classificação",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _opcaoClassificacao(
              icon: Icons.account_balance,
              titulo: "Elementos Arquitetônicos",
              subtitulo: "5 tipos de elementos históricos",
              categoria: "Elementos Arquitetônicos",
            ),

            const SizedBox(height: 10),

            _opcaoClassificacao(
              icon: Icons.house,
              titulo: "Casa Corrente",
              subtitulo: "Classificação arquitetônica",
              categoria: "Casa Corrente",
            ),

            const SizedBox(height: 10),

            _opcaoClassificacao(
              icon: Icons.window,
              titulo: "Janelas Históricas",
              subtitulo: "Classificação de tipologias de janelas",
              categoria: "Janelas Históricas",
            ),

            const SizedBox(height: 10),

            // ✅ NOVA CATEGORIA: PORTAS
            _opcaoClassificacao(
              icon: Icons.door_front_door,
              titulo: "Portas",
              subtitulo: "Classificação de portas históricas",
              categoria: "Portas",
            ),

            const SizedBox(height: 10),

            _opcaoClassificacao(
              icon: Icons.warning_amber_rounded,
              titulo: "Rachaduras",
              subtitulo: "Em breve",
              categoria: "Rachaduras",
              desabilitado: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _opcaoClassificacao({
    required IconData icon,
    required String titulo,
    required String subtitulo,
    required String categoria,
    bool desabilitado = false,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: desabilitado
            ? null
            : () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CameraScreen(categoria: categoria),
                  ),
                );
              },
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color.fromARGB(255, 129, 24, 3),
            size: 32,
          ),
          title: Text(
            titulo,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitulo),
          enabled: !desabilitado,
        ),
      ),
    );
  }

  Widget _buildMainButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: 260,
      height: 55,
      child: Material(
        color: const Color.fromARGB(255, 177, 39, 11),
        borderRadius: BorderRadius.circular(30),
        elevation: 6,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          splashColor: Colors.white24,
          highlightColor: Colors.white10,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E0E0),
      appBar: AppBar(
        title: const Text("IA Patrimônio"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _confirmarSair,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MapScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  // LOGO PRINCIPAL
                  Image.asset(
                    'assets/images/iapatrimonio.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 15),

                  // LOGOS INSTITUCIONAIS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ufop.png',
                        height: 70,
                      ),
                      const SizedBox(width: 25),
                      Image.asset(
                        'assets/images/mlbots.png',
                        height: 70,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Olá, $_nomeExibicao",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 133, 33, 13),
                    ),
                  ),

                  const SizedBox(height: 40),

                  _buildMainButton(
                    "Classificar",
                    _abrirClassificacao,
                  ),

                  const SizedBox(height: 15),

                  _buildMainButton(
                    "Histórico",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HistoryScreen(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildMainButton(
                    "Artigos Relacionados",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AboutScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DuvidasScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: Colors.redAccent.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Dúvidas",
                        style: TextStyle(
                          color: Colors.redAccent.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
              child: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }
}
