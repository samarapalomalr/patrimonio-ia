import 'package:flutter/material.dart';
import '../models/classificacao_model.dart';

class DuvidasScreen extends StatefulWidget {
  const DuvidasScreen({super.key});

  @override
  State<DuvidasScreen> createState() => _DuvidasScreenState();
}

class _DuvidasScreenState extends State<DuvidasScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final Color vinho = const Color.fromARGB(255, 201, 124, 124);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<String> _getImages(String nome) {
    switch (nome) {
      case "Elementos Arquitetônicos":
        return [
          "assets/images/igreja.png",
          "assets/images/janela.png",
          "assets/images/frontao.png",
          "assets/images/porta.png",
          "assets/images/torre.png",
        ];

      case "Rachaduras":
        return [
          "assets/images/rachadura1.png",
          "assets/images/rachadura2.png",
        ];

      case "Casa Corrente":
        return [
          "assets/images/meia_morada.png",
          "assets/images/sobrado.png",
          "assets/images/porta_janela.png",
        ];

      // 🔥 NOVA CATEGORIA
      case "Janelas Históricas":
        return [
          "assets/images/sacada.png",
          "assets/images/almofada.png",
          "assets/images/calha.png",
          "assets/images/guilhotina.png",
        ];

      default:
        return [];
    }
  }

  List<String> _getImageLabels(String nome) {
    switch (nome) {
      case "Elementos Arquitetônicos":
        return ["Igreja", "Janela", "Frontão", "Porta", "Torre"];

      case "Rachaduras":
        return ["Rachadura 1", "Rachadura 2"];

      case "Casa Corrente":
        return ["Meia Morada", "Sobrado", "Porta e Janela"];

      // 🔥 LABELS DO MODELO (ALINHADO COM EDGE IMPULSE)
      case "Janelas Históricas":
        return [
          "Porta Sacada",
          "Janela Almofada",
          "Janela Calha",
          "Janela Guilhotina",
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final classificacoes = [
      ClassificacaoModel(
        nome: "Elementos Arquitetônicos",
        descricao:
            "Componentes que formam e caracterizam a estrutura e o estilo de um edifício.",
        exemplo: "assets/images/igreja.png",
      ),
      ClassificacaoModel(
        nome: "Rachaduras",
        descricao:
            "Fissuras ou fraturas na superfície de materiais de construção.",
        exemplo: "assets/images/rachadura1.png",
      ),
      ClassificacaoModel(
        nome: "Casa Corrente",
        descricao:
            "Residência típica de padrão popular com arquitetura simples.",
        exemplo: "assets/images/sobrado.png",
      ),

      // 🔥 NOVA CATEGORIA AQUI
      ClassificacaoModel(
        nome: "Janelas Históricas",
        descricao:
            "Classificação de tipologias de janelas presentes em edificações históricas brasileiras, como sacada, guilhotina, almofada e calha.",
        exemplo: "assets/images/sacada.png",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Classificações"),
        centerTitle: true,
        backgroundColor: vinho,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: classificacoes.length,
        itemBuilder: (context, index) {
          final item = classificacoes[index];

          final animation = Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                (index / classificacoes.length),
                1,
                curve: Curves.easeOut,
              ),
            ),
          );

          return FadeTransition(
            opacity: _controller,
            child: SlideTransition(
              position: animation,
              child: _buildModernCard(item),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernCard(ClassificacaoModel item) {
    final images = _getImages(item.nome);
    final labels = _getImageLabels(item.nome);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: vinho.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.window, color: vinho, size: 26),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item.nome,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: vinho,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                item.descricao,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return _InteractiveImage(
                      imagePath: images[index],
                      label: labels[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔥 IMAGEM INTERATIVA
class _InteractiveImage extends StatefulWidget {
  final String imagePath;
  final String label;

  const _InteractiveImage({
    required this.imagePath,
    required this.label,
  });

  @override
  State<_InteractiveImage> createState() => _InteractiveImageState();
}

class _InteractiveImageState extends State<_InteractiveImage> {
  double scale = 1;

  void _onTapDown(_) => setState(() => scale = 0.95);
  void _onTapUp(_) => setState(() => scale = 1);
  void _onTapCancel() => setState(() => scale = 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _ImageFullScreen(
              imagePath: widget.imagePath,
              tag: widget.imagePath,
            ),
          ),
        );
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 150),
        child: Column(
          children: [
            Hero(
              tag: widget.imagePath,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.imagePath,
                  width: 110,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: 110,
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔍 FULLSCREEN
class _ImageFullScreen extends StatelessWidget {
  final String imagePath;
  final String tag;

  const _ImageFullScreen({
    required this.imagePath,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: tag,
          child: InteractiveViewer(
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}
