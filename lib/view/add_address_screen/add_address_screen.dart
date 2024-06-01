import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/add_address_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/functions/widget_route_functions.dart';
import 'package:flutter_grocery_store/view/add_address_screen/widgets/location_details_card.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'widgets/address_form.dart';
import 'widgets/location_details_shimmer.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<AddAddressScreenController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        elevation: 1.5,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorConstants.primaryBlack,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Consumer<AddAddressScreenController>(
                  builder: (BuildContext context, value, Widget? child) =>
                      GoogleMap(
                    padding: const EdgeInsets.only(bottom: 180),
                    mapType: MapType.normal,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      provider.mapController.complete(controller);
                    },
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(10.0842393, 76.2897847),
                      zoom: 17,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('current'),
                        position: value.currentLocation ??
                            const LatLng(10.0842393, 76.2897847),
                        icon: value.markerIcon != null
                            ? BitmapDescriptor.fromBytes(value.markerIcon!)
                            : BitmapDescriptor.defaultMarker,
                      ),
                    },
                    onCameraMoveStarted: () {
                      provider.onCameraMoveStarted();
                    },
                    onCameraIdle: () {
                      provider.onCameraMoveStopped();
                    },
                    onCameraMove: (position) {
                      provider.onCameraMove(position.target);
                    },
                  ),
                ),
                Positioned(
                  bottom: 180,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: OutlinedButton(
                      style: const ButtonStyle(
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
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.gps_fixed),
                          SizedBox(width: 10),
                          Text('Go to current location'),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryWhite,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.primaryBlack.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Consumer<AddAddressScreenController>(
                      builder: (context, value, child) {
                        if (value.mapMoving) {
                          return const LocationDetailsShimmer();
                        }

                        return LocationDetailsCard(
                          onButtonPressed: () {
                            showDetailsForm(context, provider);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDetailsForm(
      BuildContext context, AddAddressScreenController provider) {
    showMyModalBottomSheet(
      context: context,
      expand: false,
      builder: (context, scrollController) => ChangeNotifierProvider.value(
        value: provider,
        child: const AddressForm(),
      ),
    );
  }
}
