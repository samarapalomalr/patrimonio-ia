import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usuario = TextEditingController();
  final _senha = TextEditingController();
  bool _loading = false;

  String _hash(String s) => sha256.convert(utf8.encode(s)).toString();

  Future<void> _registrar() async {
    if (_usuario.text.isEmpty || _senha.text.isEmpty) {
      _msg("Preencha usuário e senha");
      return;
    }

    setState(() => _loading = true);

    final ok = await DbHelper.criarUsuario(
      _usuario.text.trim(),
      _hash(_senha.text.trim()),
    );

    setState(() => _loading = false);

    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      _msg("Usuário já existe");
    }
  }

  void _msg(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _usuario,
              decoration: const InputDecoration(labelText: "Usuário"),
            ),
            TextField(
              controller: _senha,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha"),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _registrar,
                child: _loading
                    ? const CircularProgressIndicator()
                    : const Text("Cadastrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
