// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/search_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
          ),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<SearchScreenController>(
              builder: (BuildContext context, value, Widget? child) =>
                  value.searchController.text.isEmpty
                      ? const SizedBox()
                      : IconButton.filled(
                          onPressed: () {
                            value.setTextAndSearch('');
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 15,
                          ),
                          padding: EdgeInsets.all(2),
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: MaterialStatePropertyAll(
                              ColorConstants.hintColor.withOpacity(0.4),
                            ),
                            foregroundColor: MaterialStatePropertyAll(
                                ColorConstants.primaryWhite),
                          ),
                          constraints: BoxConstraints(),
                        ),
            ),
            const SizedBox(width: 5),
            const SizedBox(
              height: 35,
              child: VerticalDivider(
                width: 1,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.mic,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
