import 'package:latlong2/latlong.dart';

class MarkerData {
  final LatLng Position;
  final String title;
  final String description;

  MarkerData({
    required this.Position,
    required this.title,
    required this.description,
  });
}
