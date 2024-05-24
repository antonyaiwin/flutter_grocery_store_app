import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<FireStoreController>(
            builder: (context, value, child) => ListView.separated(
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                var product = value.getProductById(value.favouritesList[index]);
                if (product == null) {
                  return const SizedBox();
                }
                return ProductListCard(
                  item: product,
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: value.favouritesList.length,
            ),
          ),
        ),
      ],
    );
  }
}
