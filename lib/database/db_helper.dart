import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DbHelper {
  static Database? _db;

  static Future<Database?> getConnection() async {
    // 🌐 WEB → sem banco local
    if (kIsWeb) return null;

    // 🔁 Se já abriu, retorna
    if (_db != null) return _db;

    // 🖥️ Desktop → usa FFI
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    // 📁 Caminho correto multiplataforma
    final directory = await getApplicationDocumentsDirectory();
    final pathDb = join(directory.path, 'patrimonio.db');

    _db = await openDatabase(
      pathDb,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE deteccoes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            elemento TEXT,
            categoria TEXT,
            data TEXT,
            latitude REAL,
            longitude REAL,
            userId TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password_hash TEXT
          )
        ''');
      },
    );

    return _db;
  }

  // ---------- DETECÇÕES ----------
  static Future<void> inserirDeteccao(Map<String, dynamic> dados) async {
    if (kIsWeb) return;
    final db = await getConnection();
    await db!.insert('deteccoes', dados);
  }

  static Future<List<Map<String, dynamic>>> listarDeteccoes() async {
    if (kIsWeb) {
      return [
        {
          'elemento': 'Modo Web',
          'categoria': 'Teste',
          'data': DateTime.now().toIso8601String(),
          'latitude': null,
          'longitude': null,
          'userId': 'web',
        },
      ];
    }

    final db = await getConnection();
    return db!.query('deteccoes', orderBy: 'data DESC');
  }

  // ---------- USUÁRIOS ----------
  static Future<bool> criarUsuario(String username, String passwordHash) async {
    if (kIsWeb) return false;

    final db = await getConnection();
    try {
      await db!.insert('users', {
        'username': username,
        'password_hash': passwordHash,
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> autenticarUsuario(
      String username, String passwordHash) async {
    if (kIsWeb) return false;

    final db = await getConnection();
    final res = await db!.query(
      'users',
      where: 'username = ? AND password_hash = ?',
      whereArgs: [username, passwordHash],
    );
    return res.isNotEmpty;
  }
}
