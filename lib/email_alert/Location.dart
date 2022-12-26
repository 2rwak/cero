// ARWA

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Position? _currentPosition;
  String _currentAddress = '';
  String address = '';

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      _currentPosition = position;
      await _getAddressFromLatLng();
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];
      _currentAddress =
          "${place.locality}, ${place.postalCode}, ${place.country}";
      address = _currentAddress;
      print("in lat Address :" + address);
    } catch (e) {
      print(e);
    }
  }
}
