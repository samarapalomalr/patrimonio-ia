import 'package:cloud_firestore/cloud_firestore.dart';

class DetectionModel {
  final String elemento;
  final String categoria;
  final DateTime data;
  final String? userId;
  final double? latitude;
  final double? longitude;
  final double? confiancaModelo;

  DetectionModel({
    required this.elemento,
    required this.categoria,
    required this.data,
    this.userId,
    this.latitude,
    this.longitude,
    this.confiancaModelo,
  });

  /// 🔄 SQLite
  Map<String, dynamic> toMap() {
    return {
      'elemento': elemento,
      'categoria': categoria,
      'data': data.toIso8601String(),
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'confiancaModelo': confiancaModelo,
    };
  }

  factory DetectionModel.fromMap(Map<String, dynamic> map) {
    return DetectionModel(
      elemento: map['elemento'] ?? '',
      categoria: map['categoria'] ?? '',
      data: DateTime.parse(map['data']),
      userId: map['userId'],
      latitude:
          map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null
          ? (map['longitude'] as num).toDouble()
          : null,
      confiancaModelo: map['confiancaModelo'] != null
          ? (map['confiancaModelo'] as num).toDouble()
          : null,
    );
  }

  /// 🔥 Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'elemento': elemento,
      'categoria': categoria,
      'data': Timestamp.fromDate(data),
      'userId': userId,
      'latitude': latitude,
      'longitude': longitude,
      'confiancaModelo': confiancaModelo,
    };
  }

  factory DetectionModel.fromFirestore(Map<String, dynamic> map) {
    return DetectionModel(
      elemento: map['elemento'] ?? '',
      categoria: map['categoria'] ?? '',
      data: map['data'] != null
          ? (map['data'] as Timestamp).toDate()
          : DateTime.now(), // 🔥 fallback importante
      userId: map['userId'],
      latitude:
          map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null
          ? (map['longitude'] as num).toDouble()
          : null,
      confiancaModelo: map['confiancaModelo'] != null
          ? (map['confiancaModelo'] as num).toDouble()
          : null,
    );
  }
}
