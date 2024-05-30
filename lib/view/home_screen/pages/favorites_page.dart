import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/home_screen_back_button.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: ColorConstants.primaryBlack,
        surfaceTintColor: Colors.transparent,
        leading: const HomeScreenBackButton(),
        title: const Text('Favourite Items'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<FireStoreController>(
              builder: (context, value, child) {
                if (value.favouritesList.isEmpty) {
                  return const Text('No items saved as favourites');
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    var product =
                        value.getProductById(value.favouritesList[index]);
                    if (product == null) {
                      return const SizedBox();
                    }
                    return ProductListCard(
                      item: product,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: value.favouritesList.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
