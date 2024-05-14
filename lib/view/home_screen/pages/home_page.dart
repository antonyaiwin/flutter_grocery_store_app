// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/profile_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/core/data/dummy_db.dart';
import 'package:flutter_grocery_store/utils/global_widgets/elevated_card.dart';
import 'package:flutter_grocery_store/view/profile_screen/profile_screen.dart';
import 'package:flutter_grocery_store/view/search_screen/search_screen.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_widgets/product_card.dart';
import '../../../utils/global_widgets/profile_circle_avatar.dart';
import '../widgets/sliver_category_list_view.dart';
import '../widgets/sliver_label_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (BuildContext context) =>
                          ProfileScreenController(),
                      child: ProfileScreen(),
                    ),
                  )),
              child: ProfileCircleAvatar(
                radius: 22,
                user: FirebaseAuth.instance.currentUser,
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi,',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '${FirebaseAuth.instance.currentUser?.displayName}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        SliverAppBar(
          pinned: true,
          primary: true,
          surfaceTintColor: Colors.transparent,
          titleSpacing: 0,
          title: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 0),
            child: ElevatedCard(
              elevation: 3,
              padding: EdgeInsets.only(),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Icon(
                        Icons.search,
                        color: ColorConstants.hintColor,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Search for \'Grocery\'',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.hintColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: VerticalDivider(
                        color: ColorConstants.hintColor,
                        thickness: 1,
                        width: 1,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Ink(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.qr_code_scanner),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverLabelText(
          label: 'Shop by category',
        ),
        SliverCategoryListView(),
        SliverLabelText(
          label: 'Saved',
        ),
        SliverCategoryListView(),
        SliverLabelText(
          label: 'Everything',
        ),
        SliverPadding(
          padding: EdgeInsets.all(20),
          sliver: SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 9 / 13,
            ),
            itemBuilder: (context, index) {
              var e = DummyDb.groceryItems[index];
              return ProductCard(item: e);
            },
            itemCount: DummyDb.groceryItems.length,
          ),
        ),
      ],
    );
  }
}
