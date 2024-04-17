
import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<bool> hasPermission();
  Future<bool> requestPermission();
  Future<Position> getLocation();
}
