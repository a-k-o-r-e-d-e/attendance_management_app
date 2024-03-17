import 'dart:async';

import 'package:flutter/src/widgets/basic.dart';
import 'package:geolocator/geolocator.dart';

import '../domain/repository/location_service_repo.dart';

class LocationServiceImpl extends LocationService {
  LocationServiceImpl();

  @override
  Future<bool> hasPermission() async {
    LocationPermission enabled = await Geolocator.checkPermission();
    print(enabled);
    return enabled == LocationPermission.always ||
        enabled == LocationPermission.whileInUse;
  }

  @override
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {}
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
      }
      return false;
    }
    return true;
  }

  @override
  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
