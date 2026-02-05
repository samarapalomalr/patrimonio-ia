import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../services/auth_service.dart';
import '../services/session_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usuario = TextEditingController();
  final _senha = TextEditingController();
  final _auth = AuthService();
  bool _loading = false;

  String _hash(String s) => sha256.convert(utf8.encode(s)).toString();

  Future<void> _loginLocal() async {
    if (_loading) return;

    if (_usuario.text.isEmpty || _senha.text.isEmpty) {
      _msg("Preencha usuário e senha");
      return;
    }

    setState(() => _loading = true);

    final ok = await DbHelper.autenticarUsuario(
      _usuario.text.trim(),
      _hash(_senha.text.trim()),
    );

    if (!mounted) return;

    setState(() => _loading = false);

    if (ok) {
      await SessionService.saveLocalUser(_usuario.text.trim());

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      _msg("Usuário ou senha inválidos");
    }
  }

  Future<void> _loginGoogle() async {
    if (_loading) return;

    setState(() => _loading = true);

    try {
      final user = await _auth.loginGoogle();
      if (user != null && mounted) {
        await SessionService.saveFirebaseUser();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      _msg("Erro ao logar com Google");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _msg(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }

  @override
  void dispose() {
    _usuario.dispose();
    _senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "IA Patrimônio",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              TextField(
                controller: _usuario,
                decoration: const InputDecoration(labelText: "Usuário"),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _senha,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Senha"),
                onSubmitted: (_) => _loginLocal(),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loading ? null : _loginLocal,
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Entrar"),
                ),
              ),

              TextButton(
                onPressed: _loading
                    ? null
                    : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      ),
                child: const Text("Criar conta"),
              ),

              const Divider(height: 40),

              OutlinedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text("Entrar com Google"),
                onPressed: _loading ? null : _loginGoogle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
