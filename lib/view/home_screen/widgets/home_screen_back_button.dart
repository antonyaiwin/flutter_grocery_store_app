import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../controller/screens/home_screen_controller.dart';

class HomeScreenBackButton extends StatelessWidget {
  const HomeScreenBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<HomeScreenController>().setSelecetedPageIndex(0);
      },
      icon: const Icon(Iconsax.arrow_left_2_outline),
    );
  }
}
