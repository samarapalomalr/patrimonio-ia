import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:camera/camera.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/detection_model.dart';
import '../services/history_service.dart';
import '../services/model_registry.dart';

class CameraScreen extends StatefulWidget {
  final String categoria;

  const CameraScreen({super.key, required this.categoria});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Interpreter? _interpreter;

  HistoryService? _historyService;
  User? user;

  bool _processando = false;
  bool _modeloCarregado = false;
  bool _cameraCarregada = false;

  Position? _posicaoAtual;

  late List<String> labels;
  late int inputSize;

  bool _isModelFloat = false;

  Map<String, double> _resultados = {};

  bool get _firebaseSupportedPlatform {
    return kIsWeb ||
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  @override
  void initState() {
    super.initState();

    labels = ModelRegistry.labels[widget.categoria] ?? [];
    inputSize = ModelRegistry.inputSizes[widget.categoria] ?? 96;

    if (_firebaseSupportedPlatform) {
      user = FirebaseAuth.instance.currentUser;
      _historyService = HistoryService();
    }

    _inicializarTudo();
  }

  Future<void> _inicializarTudo() async {
    await _initCamera();
    await _initModel();
    await _obterLocalizacao();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        debugPrint("Nenhuma câmera encontrada");
        return;
      }

      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      if (!mounted) return;

      setState(() => _cameraCarregada = true);
    } catch (e) {
      debugPrint("Erro ao iniciar câmera: $e");
    }
  }

  Future<void> _initModel() async {
    try {
      final modelPath = ModelRegistry.models[widget.categoria];

      if (modelPath == null) {
        debugPrint("Modelo não encontrado");
        return;
      }

      _interpreter = await Interpreter.fromAsset(
        modelPath,
        options: InterpreterOptions()..threads = 4,
      );

      final inputTensor = _interpreter!.getInputTensor(0);
      _isModelFloat = inputTensor.type.toString().contains('float');

      if (!mounted) return;

      setState(() => _modeloCarregado = true);
    } catch (e) {
      debugPrint("Erro ao carregar modelo: $e");
    }
  }

  Future<void> _obterLocalizacao() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint("GPS desativado");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        debugPrint("Permissão de localização negada");
        return;
      }

      _posicaoAtual = await Geolocator.getCurrentPosition();

      debugPrint("📍 Localização obtida:");
      debugPrint("LAT: ${_posicaoAtual?.latitude}");
      debugPrint("LNG: ${_posicaoAtual?.longitude}");
    } catch (e) {
      debugPrint("Erro localização: $e");
    }
  }

  Future<void> _classificarImagem() async {
    if (_processando) return;
    if (!_modeloCarregado || !_cameraCarregada) return;
    if (labels.isEmpty) return;

    setState(() => _processando = true);

    try {
      final picture = await _cameraController!.takePicture();
      final bytes = await File(picture.path).readAsBytes();

      img.Image? image = img.decodeImage(bytes);
      if (image == null) {
        setState(() => _processando = false);
        return;
      }

      image = img.bakeOrientation(image);

      /// 🔥 GARANTE LOCALIZAÇÃO ANTES DE SALVAR
      if (_posicaoAtual == null) {
        await _obterLocalizacao();
      }

      /// 🔥 BLOQUEIA SE NÃO TIVER LOCALIZAÇÃO
      if (_posicaoAtual == null) {
        debugPrint("❌ Sem localização, não salvando");
        setState(() => _processando = false);
        return;
      }

      final resized = img.copyResizeCropSquare(
        image,
        size: inputSize,
      );

      dynamic input;

      if (_isModelFloat) {
        input = List.generate(
          1,
          (_) => List.generate(
            inputSize,
            (_) => List.generate(
              inputSize,
              (_) => List<double>.filled(3, 0.0),
            ),
          ),
        );

        for (int y = 0; y < inputSize; y++) {
          for (int x = 0; x < inputSize; x++) {
            final pixel = resized.getPixel(x, y);
            input[0][y][x][0] = pixel.r / 255.0;
            input[0][y][x][1] = pixel.g / 255.0;
            input[0][y][x][2] = pixel.b / 255.0;
          }
        }
      } else {
        const scale = 0.00390625;
        const zeroPoint = -128;

        input = List.generate(
          1,
          (_) => List.generate(
            inputSize,
            (_) => List.generate(
              inputSize,
              (_) => List<int>.filled(3, 0),
            ),
          ),
        );

        for (int y = 0; y < inputSize; y++) {
          for (int x = 0; x < inputSize; x++) {
            final pixel = resized.getPixel(x, y);

            input[0][y][x][0] = ((pixel.r / 255.0) / scale + zeroPoint).round();
            input[0][y][x][1] = ((pixel.g / 255.0) / scale + zeroPoint).round();
            input[0][y][x][2] = ((pixel.b / 255.0) / scale + zeroPoint).round();
          }
        }
      }

      dynamic output = _isModelFloat
          ? List.generate(1, (_) => List<double>.filled(labels.length, 0.0))
          : List.generate(1, (_) => List<int>.filled(labels.length, 0));

      _interpreter!.run(input, output);

      List<double> probs;

      if (_isModelFloat) {
        probs = List<double>.from(output[0]);
      } else {
        final outputTensor = _interpreter!.getOutputTensor(0);
        probs = output[0]
            .map<double>((e) =>
                outputTensor.params.scale * (e - outputTensor.params.zeroPoint))
            .toList();
      }

      Map<String, double> resultadosTemp = {};

      for (int i = 0; i < labels.length; i++) {
        resultadosTemp[labels[i]] = probs[i] * 100;
      }

      final sorted = resultadosTemp.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      if (!mounted) return;

      setState(() {
        _resultados = Map.fromEntries(sorted);
      });

      final maxScore = probs.reduce((a, b) => a > b ? a : b);
      final index = probs.indexOf(maxScore);

      final detection = DetectionModel(
        elemento: labels[index],
        categoria: widget.categoria,
        confiancaModelo: maxScore,
        data: DateTime.now(),
        userId: user?.uid,
        latitude: _posicaoAtual!.latitude,
        longitude: _posicaoAtual!.longitude,
      );

      debugPrint("💾 Salvando detecção com localização");

      if (_firebaseSupportedPlatform &&
          _historyService != null &&
          user != null) {
        await _historyService!.salvarDeteccao(detection);
      }
    } catch (e) {
      debugPrint("Erro: $e");
    }

    if (mounted) setState(() => _processando = false);
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraCarregada || _cameraController == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoria),
        backgroundColor: const Color.fromARGB(255, 129, 24, 3),
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          CameraPreview(_cameraController!),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _resultados.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key,
                            style: const TextStyle(color: Colors.white)),
                        Text(
                          "${entry.value.toStringAsFixed(2)}%",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _modeloCarregado
            ? const Color.fromARGB(255, 129, 24, 3)
            : Colors.grey,
        icon: const Icon(Icons.camera, color: Colors.white),
        label: Text(
          !_modeloCarregado
              ? 'CARREGANDO...'
              : _processando
                  ? 'PROCESSANDO...'
                  : 'CLASSIFICAR',
        ),
        onPressed:
            (!_modeloCarregado || _processando) ? null : _classificarImagem,
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _interpreter?.close();
    super.dispose();
  }
}
