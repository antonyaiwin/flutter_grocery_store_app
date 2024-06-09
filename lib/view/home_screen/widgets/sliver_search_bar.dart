import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../controller/screens/search_screen_controller.dart';
import '../../../core/constants/color_constants.dart';
import '../../search_screen/search_screen.dart';

class SliverSearchBar extends StatelessWidget {
  SliverSearchBar({
    super.key,
  });
  final BorderRadius borderRadius = BorderRadius.circular(15);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      clipBehavior: Clip.none,
      pinned: true,
      primary: true,
      titleSpacing: 0,
      collapsedHeight: kToolbarHeight + 5,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: borderRadius,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (BuildContext context) => SearchScreenController(
                        context: context,
                      ),
                      child: const SearchScreen(),
                    ),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: ColorConstants.searchFieldFill2,
                    borderRadius: borderRadius,
                    border: Border.all(
                      color: ColorConstants.hintColor.withOpacity(0.15),
                    ),
                  ),
                  padding: const EdgeInsets.only(),
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
            InkWell(
              borderRadius: borderRadius,
              onTap: () {},
              child: Ink(
                width: 50,
                decoration: BoxDecoration(
                  color: ColorConstants.searchFieldFill2,
                  borderRadius: borderRadius,
                  border: Border.all(
                    color: ColorConstants.hintColor.withOpacity(0.15),
                  ),
                ),
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
