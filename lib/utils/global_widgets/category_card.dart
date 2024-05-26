import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_grocery_store/controller/screens/category_view_screen_controller.dart';
import 'package:flutter_grocery_store/view/category_view_screen/category_view_screen.dart';

import '../../model/category_model.dart';
import 'elevated_card.dart';
import 'my_network_image.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.item,
  });

  final CategoryModel item;

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      elevation: 1.5,
      height: 150,
      width: 100,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
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
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Stack(
            children: [
              Positioned.fill(
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
