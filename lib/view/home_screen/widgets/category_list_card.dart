import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';
import '../../../model/category_model.dart';
import '../../../utils/global_widgets/my_network_image.dart';

class CategoryListCard extends StatelessWidget {
  const CategoryListCard({
    super.key,
    required this.category,
    required this.isSelected,
    this.onTap,
    required this.isPrevious,
    required this.isNext,
  });

  final CategoryModel category;
  final bool isSelected;
  final bool isPrevious;
  final bool isNext;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: isSelected
            ? null
            : BoxDecoration(
                color: ColorConstants.categorySliderBackground,
                borderRadius: BorderRadius.only(
                  topRight: isNext ? const Radius.circular(15) : Radius.zero,
                  bottomRight:
                      isPrevious ? const Radius.circular(15) : Radius.zero,
                ),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyNetworkImage(
              imageUrl: category.imageUrl ?? '',
              height: 80,
              width: 80,
            ),
            Text(
              category.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? null : ColorConstants.hintColor,
                fontWeight: isSelected ? FontWeight.w500 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
