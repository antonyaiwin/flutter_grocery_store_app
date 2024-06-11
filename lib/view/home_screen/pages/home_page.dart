import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firebase_auth_controller.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/controller/screens/home_screen_controller.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/sliver_pending_orders_view.dart';
import 'package:flutter_grocery_store/view/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

import '../../../utils/global_widgets/product_card.dart';
import '../../../utils/global_widgets/profile_circle_avatar.dart';
import '../widgets/sliver_category_list_view.dart';
import '../widgets/sliver_label_text.dart';
import '../widgets/sliver_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back,',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Consumer<FirebaseAuthController>(
                builder: (BuildContext context, auth, Widget? child) => Text(
                  auth.currentUser?.displayName ?? 'User',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              ),
              child: const ProfileCircleAvatar(
                radius: 22,
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
        SliverSearchBar(),
        const SliverPendingOrdersView(),
        SliverLabelText(
          label: 'Shop by category',
          onSeeAllPressed: () {
            context.read<HomeScreenController>().setSelecetedPageIndex(1);
          },
        ),
        const SliverCategoryListView(),
        const SliverLabelText(
          label: 'All Products',
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 300),
          sliver: Consumer<FireStoreController>(
            builder: (BuildContext context, value, Widget? child) =>
                SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 20 / 28,
              ),
              itemBuilder: (context, index) {
                var e = value.productList[index];
                return ProductCard(item: e);
              },
              itemCount: value.productList.length,
            ),
          ),
        ),
      ],
    );
  }
}
