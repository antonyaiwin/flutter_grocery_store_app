import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/search_screen_controller.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:provider/provider.dart';

import 'widgets/my_search_bar.dart';
import 'widgets/search_placeholder.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const MySearchBar(),
      ),
      body: Consumer<SearchScreenController>(
        builder: (context, value, child) {
          if (value.productList.isEmpty && value.text.isNotEmpty) {
            return Center(
              child: Text(
                'No items found for search term \'${value.text}\'',
                textAlign: TextAlign.center,
              ),
            );
          } else if (value.productList.isEmpty && value.text.isEmpty) {
            return const SearchPlaceholder();
          }
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) =>
                ProductListCard(item: value.productList[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: value.productList.length,
          );
        },
      ),
    );
  }
}
