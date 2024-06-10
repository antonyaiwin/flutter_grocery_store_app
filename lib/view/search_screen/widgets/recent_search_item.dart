import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../controller/screens/search_screen_controller.dart';
import '../../../core/constants/color_constants.dart';
import '../../../model/recent_search_model.dart';

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({
    super.key,
    required this.item,
  });

  final RecentSearchModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context
            .read<SearchScreenController>()
            .setTextAndSearch(item.text ?? '');
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstants.hintColor.withOpacity(0.5),
            width: 0.4,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.search_normal_1_outline,
              size: 15,
              color: ColorConstants.hintColor.withOpacity(0.5),
            ),
            const SizedBox(width: 5),
            Text(item.text ?? ''),
          ],
        ),
      ),
    );
  }
}
