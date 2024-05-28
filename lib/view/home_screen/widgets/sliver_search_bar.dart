import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../core/constants/color_constants.dart';
import '../../search_screen/search_screen.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      clipBehavior: Clip.none,
      pinned: true,
      primary: true,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      collapsedHeight: kToolbarHeight + 5,
      shadowColor: ColorConstants.primaryBlack,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.primaryWhite,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ColorConstants.hintColor.withOpacity(0.15),
                  ),
                ),
                padding: const EdgeInsets.only(),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Iconsax.search_normal_1_outline,
                          color: ColorConstants.hintColor,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Search for \'Grocery\'',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorConstants.hintColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: ColorConstants.primaryWhite,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: ColorConstants.hintColor.withOpacity(0.15),
                ),
              ),
              child: InkWell(
                onTap: () {},
                child: Ink(
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Iconsax.scanning_bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
