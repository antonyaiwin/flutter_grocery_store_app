// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/search_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstants.primaryWhite,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorConstants.primaryBlack,
        title: SearchBar(),
      ),
      body: Consumer<SearchScreenController>(
        builder: (context, value, child) {
          if (value.productList.isEmpty) {
            return Center(
              child: Text(
                value.text.isEmpty
                    ? 'Search for a product'
                    : 'No items found for search term \'${value.text}\'',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.all(10),
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

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            controller: context.read<SearchScreenController>().searchController,
            decoration: InputDecoration(
              hintText: 'Search for rice, dal, pepsi and more',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorConstants.hintColor.withOpacity(0.25),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 35,
                    child: VerticalDivider(
                      width: 1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
