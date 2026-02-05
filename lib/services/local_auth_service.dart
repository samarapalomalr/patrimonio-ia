import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../database/db_helper.dart';
import '../models/detection_model.dart';

class HistoryService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔎 Usuário está logado no Firebase?
  bool get isLogged => _auth.currentUser != null;

  /// 💾 Salvar inspeção (LOCAL sempre + Firebase se logado)
  Future<void> salvarDeteccao(DetectionModel detection) async {
    // 🔹 SALVA LOCAL
    await DbHelper.inserirDeteccao({
      'elemento': detection.elemento,
      'categoria': detection.categoria,
      'data': detection.data.toIso8601String(),
      'latitude': detection.latitude,
      'longitude': detection.longitude,
      'userId': detection.userId,
    });

    // 🔹 SALVA NO FIREBASE SE LOGADO
    if (isLogged) {
      final user = _auth.currentUser!;
      await _db
          .collection('users')
          .doc(user.uid)
          .collection('historico')
          .add(detection.toFirestore());
    }
  }

  /// 📡 HISTÓRICO UNIFICADO
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
      // 🔹 USUÁRIO LOCAL / ANÔNIMO
      final listaLocal = await DbHelper.listarDeteccoes();
      yield listaLocal.map((e) => DetectionModel.fromMap(e)).toList();
    }
  }
}
