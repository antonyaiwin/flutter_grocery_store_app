import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/model/address_model.dart';
import 'package:flutter_grocery_store/utils/functions/map_utils.dart';
import 'package:flutter_grocery_store/utils/global_widgets/elevated_card.dart';
import 'package:icons_plus/icons_plus.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.address,
    this.onTap,
    this.onDeletePressed,
    this.onEditPressed,
    required this.isDefault,
  });

  final AddressModel address;
  final void Function()? onTap;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDefault
              ? ColorConstants.primaryColor.withOpacity(0.07)
              : ColorConstants.primaryWhite,
          borderRadius: BorderRadius.circular(15),
          border: isDefault
              ? Border.all(
                  color: ColorConstants.primaryColor,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              address.name ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(address.buildingName ?? ''),
            if (address.floor != null && address.floor!.isNotEmpty)
              Text.rich(
                TextSpan(
                  text: 'Floor:',
                  children: [
                    TextSpan(
                      text: ' ${address.floor!}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorConstants.black3c,
                          ),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorConstants.hintColor,
                    ),
              ),
            if (address.landmark != null && address.landmark!.isNotEmpty)
              Text.rich(
                TextSpan(
                  text: 'Landmark:',
                  children: [
                    TextSpan(
                      text: ' ${address.landmark!}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorConstants.black3c,
                          ),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorConstants.hintColor,
                    ),
              ),
            if (address.phoneNumber != null && address.phoneNumber!.isNotEmpty)
              Text.rich(
                TextSpan(
                  text: 'Phone:',
                  children: [
                    TextSpan(
                      text: ' ${address.phoneNumber!}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: ColorConstants.black3c,
                          ),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorConstants.hintColor,
                    ),
              ),
            const SizedBox(height: 5),
            Row(
              children: [
                IconButton(
                  onPressed: onEditPressed,
                  icon: const Icon(Iconsax.edit_outline),
                  iconSize: 20,
                  color: ColorConstants.primaryColor,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  constraints:
                      const BoxConstraints(maxHeight: 40, maxWidth: 40),
                  padding: const EdgeInsets.all(5),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: onDeletePressed,
                  icon: const Icon(Iconsax.trash_outline),
                  iconSize: 20,
                  color: ColorConstants.primaryColor,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  constraints:
                      const BoxConstraints(maxHeight: 40, maxWidth: 40),
                  padding: const EdgeInsets.all(5),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    MapUtils.openMap(
                        address.latitude ?? 0, address.longitude ?? 0);
                  },
                  icon: const Icon(Iconsax.location_outline),
                  iconSize: 20,
                  color: ColorConstants.primaryColor,
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  constraints:
                      const BoxConstraints(maxHeight: 40, maxWidth: 40),
                  padding: const EdgeInsets.all(5),
                ),
                if (isDefault) ...[
                  const Spacer(),
                  const Icon(
                    Icons.radio_button_checked,
                    color: ColorConstants.primaryColor,
                  )
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
