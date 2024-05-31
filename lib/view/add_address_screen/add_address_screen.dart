// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/add_address_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<AddAddressScreenController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        elevation: 5,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorConstants.primaryBlack,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    provider.mapController.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(10.0842393, 76.2897847),
                    zoom: 17,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('value'),
                      position: LatLng(10.0842393, 76.2897847),
                      zIndex: 10,
                    ),
                  },
                ),
                Positioned(
                  bottom: 15,
                  left: 60,
                  right: 60,
                  child: Center(
                    child: OutlinedButton(
                      style: ButtonStyle(
                        shadowColor: MaterialStatePropertyAll(
                            ColorConstants.primaryBlack),
                        elevation: MaterialStatePropertyAll(10),
                        backgroundColor: MaterialStatePropertyAll(
                          ColorConstants.primaryWhite,
                        ),
                      ),
                      onPressed: () {
                        provider.getCurrentLocation();
                      },
                      child: Text(
                        'Go to current location',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Center(
                child: Text('Confirm Location'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
