import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationState with ChangeNotifier {
  Position _currentPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime(2022),
    accuracy: 0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );
  Placemark _currentAddress = Placemark();

  Position get currentPosition {
    return _currentPosition;
  }

  Placemark get currentAddress {
    return _currentAddress;
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location Not Available');
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        // forceAndroidLocationManager: true,
      );

      _currentPosition = position;
      if (kDebugMode) {
        print('current position is$_currentPosition');
      }
      getAddressFromCoords();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getAddressFromCoords() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition.latitude,
        _currentPosition.longitude,
      );

      Placemark place = placemarks[0];
      _currentAddress = place;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // double distanceBetweenCoords(
  //   endLatitude,
  //   endLongitude,
  // ) {
  //   if (_currentPosition == null) {
  //     getCurrentLocation();
  //   }
  //   double distanceInMeters = Geolocator.distanceBetween(
  //     _currentPosition?.latitude ?? 0,
  //     _currentPosition?.longitude ?? 0,
  //     endLatitude,
  //     endLongitude,
  //   );
  //   return distanceInMeters / 1000;
  // }
}
