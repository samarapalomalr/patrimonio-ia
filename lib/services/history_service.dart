import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/db_helper.dart';
import '../models/detection_model.dart';

class HistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLogged => _auth.currentUser != null;

  /// 💾 Salvar inspeção (LOCAL + Firebase)
  Future<void> salvarDeteccao(DetectionModel detection) async {
    /// 🔹 SQLite
    await DbHelper.inserirDeteccao(detection.toMap());

    /// 🔹 Firebase
    if (isLogged) {
      final user = _auth.currentUser!;
      await _db
          .collection('users')
          .doc(user.uid)
          .collection('historico')
          .add(detection.toFirestore());
    }
  }

  /// 📊 Histórico
  Stream<List<DetectionModel>> listarDeteccoes() async* {
    if (isLogged) {
      final user = _auth.currentUser!;
      yield* _db
          .collection('users')
          .doc(user.uid)
          .collection('historico')
          .orderBy('data', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map((doc) => DetectionModel.fromFirestore(doc.data()))
                .toList();
          });
    } else {
      final listaLocal = await DbHelper.listarDeteccoes();
      yield listaLocal.map((e) => DetectionModel.fromMap(e)).toList();
    }
  }
}
