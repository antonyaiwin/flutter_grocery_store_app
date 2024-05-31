import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddAddressScreenController extends ChangeNotifier {
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Location location = Location();

  Future<void> getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    if (_locationData != null &&
        _locationData!.latitude != null &&
        _locationData!.longitude != null) {
      gotoLocation(LatLng(_locationData!.latitude!, _locationData!.longitude!));
    }
  }

  Future<void> gotoLocation(LatLng target) async {
    final GoogleMapController controller = await mapController.future;

    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: 17,
        ),
      ),
    );
  }
}
