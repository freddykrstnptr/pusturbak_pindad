import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:pusturbak_pindad/maps/marker_data.dart';

class MapScreen extends StatefulWidget {
  final MapController controller;

  const MapScreen({super.key, required this.controller});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedPosition;
  LatLng? _draggedPosition;
  bool _isDragging = false;
  final List<Marker> _markers = [];
  LatLng? _mylocation;

  @override
  void initState() {
    super.initState();
    _checkGps();
  }

  void _checkGps() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;
  }

  void _showMarketDialog(BuildContext context, LatLng tappedPoint) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tambah Marker?"),
          content: Text("Apakah Anda ingin menambahkan marker di sini?"),
          actions: [
            TextButton(
              child: Text("Tidak"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Ya"),
              onPressed: () {
                setState(() {
                  _markers.add(
                    Marker(
                      point: tappedPoint,
                      width: 80,
                      height: 80,
                      builder: (context) => Icon(
                        Icons.location_on,
                        color: Colors.indigo,
                        size: 40,
                      ),
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: widget.controller,
          options: MapOptions(
            center: LatLng(-6.9175, 107.6191), // Default center
            zoom: 13.0,
            onTap: (tapPos, latLng) {
              setState(() {
                _selectedPosition = latLng;
                _draggedPosition = latLng;
              });
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayer(markers: _markers),
            if (_isDragging && _draggedPosition != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _draggedPosition!,
                    width: 80,
                    height: 80,
                    builder: (context) => Icon(
                      Icons.location_on,
                      color: Colors.indigo,
                      size: 40,
                    ),
                  ),
                ],
              ),
            if (_mylocation != null)
              MarkerLayer(
                markers: [
                  Marker(
                    point: _mylocation!,
                    width: 80,
                    height: 80,
                    builder: (context) => Icon(
                      Icons.location_on,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                ],
              ),
          ],
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: FloatingActionButton(
            backgroundColor: _isDragging ? Colors.redAccent : Colors.indigo,
            foregroundColor: Colors.white,
            onPressed: () {
              setState(() {
                _isDragging = !_isDragging;
                if (!_isDragging) _draggedPosition = null;
              });
            },
            child: Icon(
              _isDragging ? Icons.wrong_location : Icons.add_location,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                foregroundColor: Colors.indigo,
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );
                  _mylocation = LatLng(position.latitude, position.longitude);
                  widget.controller.move(_mylocation!, 15);
                  setState(() {});
                },
                child: Icon(Icons.location_searching),
              ),
              if (_isDragging)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (_draggedPosition != null) {
                        _showMarketDialog(context, _draggedPosition!);
                      }
                      setState(() {
                        _isDragging = false;
                        _draggedPosition = null;
                      });
                    },
                    child: Icon(Icons.check),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
