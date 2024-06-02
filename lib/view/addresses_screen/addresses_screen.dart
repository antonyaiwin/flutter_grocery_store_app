import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';

import 'widgets/address_screen_body.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My addresses'),
        backgroundColor: ColorConstants.primaryWhite,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorConstants.primaryBlack,
      ),
      body: const AddressScreenBody(),
    );
  }
}
