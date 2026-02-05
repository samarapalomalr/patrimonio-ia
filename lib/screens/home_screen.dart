import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/session_service.dart';
import 'camera_screen.dart';
import 'history_screen.dart';
import 'about_screen.dart';
import 'login_screen.dart';
import 'map_screen.dart';
import 'duvidas_screen.dart';
import 'settings_screen.dart'; // ✅ IMPORTA CONFIGURAÇÕES

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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

            const SizedBox(height: 15),

            _opcaoClassificacao(
              icon: Icons.warning_amber_rounded,
              titulo: "Rachaduras",
              subtitulo: "Análise estrutural (em breve)",
              categoria: "Rachaduras",
              desabilitado: true,
            ),

            const SizedBox(height: 15),

            // ✅ NOVA CLASSIFICAÇÃO
            _opcaoClassificacao(
              icon: Icons.house,
              titulo: "Casa Corrente",
              subtitulo: "Classificação arquitetônica (em breve)",
              categoria: "Casa Corrente",
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
    return ListTile(
      leading: Icon(icon, color: Colors.orange[800], size: 32),
      title: Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitulo),
      enabled: !desabilitado,
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
    );
  }

  Widget _buildMainButton(String label, VoidCallback onTap) {
    return SizedBox(
      width: 260,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 234, 80, 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 6,
        ),
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
    );
  }

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
                  Text(
                    "Olá, $_nomeExibicao",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 80, 8),
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildMainButton("Classificar", _abrirClassificacao),
                  const SizedBox(height: 15),
                  _buildMainButton(
                    "Histórico",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HistoryScreen()),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildMainButton(
                    "Artigos Relacionados",
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DuvidasScreen()),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Colors.redAccent.shade700,
                    size: 22,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Dúvidas sobre cada classificação",
                    style: TextStyle(
                      color: Colors.redAccent.shade700,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
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
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
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
