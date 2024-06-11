import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

import 'package:flutter_grocery_store/controller/screens/category_view_screen_controller.dart';
import 'package:flutter_grocery_store/view/category_view_screen/category_view_screen.dart';

import '../../model/category_model.dart';
import 'my_network_image.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.item,
  });

  final CategoryModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(100),
        bottom: Radius.circular(30),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) =>
                  CategoryViewScreenController(context, category: item),
              child: const CategoryViewScreen(),
            ),
          ),
        );
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: ColorConstants.primaryBlue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(100),
              ),
              child: MyNetworkImage(
                imageUrl: item.imageUrl ?? '',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            item.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
