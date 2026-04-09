import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/db_helper.dart';
import '../models/detection_model.dart';

class HistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLogged => _auth.currentUser != null;

  /// 💾 Salvar inspeção
  Future<void> salvarDeteccao(DetectionModel detection) async {
    try {
      print("📥 Salvando LOCAL:");
      print("LAT: ${detection.latitude}");
      print("LNG: ${detection.longitude}");

      /// 🔹 LOCAL
      await DbHelper.inserirDeteccao(detection.toMap());

      /// 🔹 FIREBASE
      if (isLogged) {
        final user = _auth.currentUser!;

        print("☁️ Salvando no Firebase");

        await _db
            .collection('users')
            .doc(user.uid)
            .collection('historico')
            .add({
          ...detection.toFirestore(),

          // 🔥 GARANTE que vai explicitamente
          'latitude': detection.latitude,
          'longitude': detection.longitude,
        });
      }
    } catch (e) {
      print("❌ Erro ao salvar detecção: $e");
    }
  }

  /// 📊 Histórico
  Stream<List<DetectionModel>> listarDeteccoes() async* {
    List<DetectionModel> listaFinal = [];

    final listaLocal = await DbHelper.listarDeteccoes();

    listaFinal.addAll(
      listaLocal.map((e) {
        final d = DetectionModel.fromMap(e);

        print("📍 LOCAL DB:");
        print("LAT: ${d.latitude}");
        print("LNG: ${d.longitude}");

        return d;
      }),
    );

    if (isLogged) {
      final user = _auth.currentUser!;

      yield* _db
          .collection('users')
          .doc(user.uid)
          .collection('historico')
          .orderBy('data', descending: true)
          .snapshots()
          .map((snapshot) {
        final listaFirebase = snapshot.docs.map((doc) {
          final d = DetectionModel.fromFirestore(doc.data());

          print("☁️ FIREBASE:");
          print("LAT: ${d.latitude}");
          print("LNG: ${d.longitude}");

          return d;
        }).toList();

        final combinada = [...listaFirebase, ...listaFinal];

        combinada.sort((a, b) => b.data.compareTo(a.data));

        return combinada;
      });
    } else {
      listaFinal.sort((a, b) => b.data.compareTo(a.data));
      yield listaFinal;
    }
  }
}
