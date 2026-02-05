import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../services/history_service.dart';
import '../models/detection_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryService service = HistoryService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Inspeções'),
        backgroundColor: Colors.orange[800],
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<DetectionModel>>(
        stream: service.listarDeteccoes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma inspeção com localização'),
            );
          }

          final deteccoes = snapshot.data!;

          final markers = deteccoes
              .where((d) => d.latitude != null && d.longitude != null)
              .map(
                (d) => Marker(
                  point: LatLng(d.latitude!, d.longitude!),
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: () {
                      _mostrarDetalhes(context, d);
                    },
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 36,
                    ),
                  ),
                ),
              )
              .toList();

          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                deteccoes.first.latitude!,
                deteccoes.first.longitude!,
              ),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.patrimonio_ia',
              ),
              MarkerLayer(markers: markers),
            ],
          );
        },
      ),
    );
  }

  void _mostrarDetalhes(BuildContext context, DetectionModel d) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              d.elemento,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Categoria: ${d.categoria}'),
            const SizedBox(height: 6),
            Text('Data: ${d.data.day}/${d.data.month}/${d.data.year}'),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.location_on, color: Colors.orange),
                SizedBox(width: 6),
                Text('Localização registrada'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
