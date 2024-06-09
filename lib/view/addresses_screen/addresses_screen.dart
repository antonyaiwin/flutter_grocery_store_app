import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';

import 'widgets/address_screen_body.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.scaffoldBackgroundColor2,
      appBar: AppBar(
        title: const Text('My addresses'),
      ),
      body: const AddressScreenBody(),
    );
  }
}
