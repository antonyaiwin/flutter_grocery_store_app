import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/cart_controller.dart';
import '../../../core/constants/color_constants.dart';
import '../../../utils/functions/functions.dart';
import '../../addresses_screen/widgets/address_screen_body.dart';

class AddressSelectBottomSheetContent extends StatelessWidget {
  const AddressSelectBottomSheetContent({
    super.key,
    this.scrollController,
  });
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0).copyWith(bottom: 0),
          child: Text(
            'Select Address',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(),
        Expanded(
            child: AddressScreenBody(
          isAddressScreen: false,
          scrollController: scrollController,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 0),
          child: ElevatedButton(
            onPressed: () {
              if (context.read<CartController>().selectedAddress == null) {
                showErrorSnackBar(
                    context: context, content: 'Please select an address');
              } else {
                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proceed',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: ColorConstants.primaryWhite,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
