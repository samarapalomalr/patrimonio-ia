import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/detection_model.dart';
import '../services/history_service.dart';

class CameraScreen extends StatefulWidget {
  final String categoria;

  const CameraScreen({super.key, required this.categoria});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Interpreter _interpreter;

  final HistoryService _historyService = HistoryService();
  final User? user = FirebaseAuth.instance.currentUser;

  bool _processando = false;
  Position? _posicaoAtual;

  /// 🔖 Labels do modelo Edge Impulse
  final List<String> labels = ['Frontão', 'Igreja', 'Janela', 'Porta', 'Torre'];

  @override
  void initState() {
    super.initState();
    _initCamera();
    _initModel();
    _obterLocalizacao();
  }

  /// 📸 CÂMERA
  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    await _cameraController.initialize();
    setState(() {});
  }

  /// 🧠 MODELO
  Future<void> _initModel() async {
    _interpreter = await Interpreter.fromAsset(
      'model/model.tflite',
      options: InterpreterOptions()..threads = 4,
    );
  }

  /// 📍 GPS
  Future<void> _obterLocalizacao() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever)
      return;

    _posicaoAtual = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// 🧠 CLASSIFICAÇÃO
  Future<void> _classificarImagem() async {
    if (_processando) return;
    setState(() => _processando = true);

    final picture = await _cameraController.takePicture();
    final bytes = await File(picture.path).readAsBytes();
    final image = img.decodeImage(bytes)!;

    final resized = img.copyResize(image, width: 224, height: 224);

    // 🔄 Pré-processamento CORRETO
    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(224, (x) {
          final pixel = resized.getPixel(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        }),
      ),
    );

    final output = List.filled(labels.length, 0.0).reshape([1, labels.length]);

    _interpreter.run(input, output);

    final scores = output[0];
    final maxScore = scores.reduce((a, b) => a > b ? a : b);
    final index = scores.indexOf(maxScore);

    final detection = DetectionModel(
      elemento: labels[index],
      categoria: widget.categoria,
      confiancaModelo: maxScore,
      data: DateTime.now(),
      userId: user?.uid,
      latitude: _posicaoAtual?.latitude,
      longitude: _posicaoAtual?.longitude,
    );

    await _historyService.salvarDeteccao(detection);

    setState(() => _processando = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✔️ ${labels[index]} (${(maxScore * 100).toStringAsFixed(1)}%)',
        ),
        backgroundColor: Colors.orange[800],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria),
        backgroundColor: Colors.orange[800],
        foregroundColor: Colors.white,
      ),
      body: CameraPreview(_cameraController),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange[800],
        icon: const Icon(Icons.camera, color: Colors.white),
        label: const Text('CLASSIFICAR'),
        onPressed: _classificarImagem,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _interpreter.close();
    super.dispose();
  }
}
