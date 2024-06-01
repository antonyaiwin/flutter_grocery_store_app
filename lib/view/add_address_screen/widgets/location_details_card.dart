import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/add_address_screen_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_constants.dart';
import '../../../core/constants/image_constants.dart';

class LocationDetailsCard extends StatelessWidget {
  const LocationDetailsCard({super.key, this.onButtonPressed});
  final void Function()? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    var value = context.read<AddAddressScreenController>();
    var address = value.getAddressMap();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivering to',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorConstants.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: ColorConstants.primaryBlack,
              width: 0.1,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                ImageConstants.locationPinIcon,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: value.placemarks.isEmpty
                    ? Text(
                        'We couldn\'t find the address of the location.\nPlease try again!',
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            address['title'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            address['subtitle'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: ColorConstants.hintColor,
                                    ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onButtonPressed,
          child: const Center(
            child: Text('Confirm Location'),
          ),
        ),
      ],
    );
  }
}
