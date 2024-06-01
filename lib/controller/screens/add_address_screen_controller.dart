// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grocery_store/core/constants/image_constants.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../utils/functions/debouncer.dart';
import '../../utils/functions/image_functions.dart';

class AddAddressScreenController extends ChangeNotifier {
  Uint8List? markerIcon;
  List<geocoding.Placemark> placemarks = [];
  late Debouncer debouncer;
  bool mapMoving = false;
  bool _serviceEnabled = false;
  LatLng? currentLocation;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData;

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController flatController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  Location location = Location();

  AddAddressScreenController() : debouncer = Debouncer(milliSeconds: 500) {
    loadMarkerImage();
  }

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

  void onCameraMoveStarted() {
    mapMoving = true;
    notifyListeners();
  }

  void onCameraMove(LatLng target) {
    currentLocation = target;
    onCameraMoveStopped();
    notifyListeners();
  }

  Future<void> onCameraMoveStopped() async {
    debouncer.run(() async {
      log('on stop');

      try {
        if (currentLocation != null) {
          placemarks = await geocoding.placemarkFromCoordinates(
              currentLocation!.latitude, currentLocation!.longitude);
        }
      } on Exception catch (e) {
        log(e.toString());
        placemarks.clear();

        // log(placemarks.toString());
        mapMoving = false;
        notifyListeners();
      }
    });
    var map = getAddressMap();
    locationController.text = '${map['title'] ?? ''}, ${map['subtitle']}';
  }

  Future<void> loadMarkerImage() async {
    markerIcon = await getBytesFromAsset(ImageConstants.locationPinIcon, 100);
    notifyListeners();
  }

  Map getAddressMap() {
    if (placemarks.isEmpty) {
      return {};
    }
    var place = placemarks.first;
    if (isNullOrEmpty(place.subThoroughfare) &&
        isNullOrEmpty(place.thoroughfare)) {
      return {
        'title': place.subLocality,
        'subtitle': place.locality,
      };
    } else {
      return {
        'title':
            '${isNullOrEmpty(place.subThoroughfare) ? '' : '${place.subThoroughfare!.trim()}, '}${place.thoroughfare}',
        'subtitle':
            '${isNullOrEmpty(place.subLocality) ? '' : '${place.subLocality!.trim()}, '}${place.locality}',
      };
    }
  }

  bool isNullOrEmpty(String? value) {
    return value == null || value.isEmpty;
  }

  void saveAddress() {
    if (formKey.currentState!.validate()) {}
  }
}
