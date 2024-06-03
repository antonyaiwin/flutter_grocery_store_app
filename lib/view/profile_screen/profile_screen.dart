import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/orders_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/global_widgets/profile_circle_avatar.dart';
import 'package:flutter_grocery_store/view/addresses_screen/addresses_screen.dart';
import 'package:flutter_grocery_store/view/orders_screen/orders_screen.dart';
import 'package:flutter_grocery_store/view/splash_screen/splash_screen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../controller/firebase/firebase_auth_controller.dart';
import '../../controller/screens/profile_edit_screen_controller.dart';
import '../profile_edit_screen/profile_edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileCircleAvatar(
              radius: 70,
            ),
            const SizedBox(height: 10),
            Consumer<FirebaseAuthController>(
              builder: (BuildContext context, auth, Widget? child) => Text(
                auth.currentUser?.displayName ?? 'User',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorConstants.hintColor,
                  ),
            ),
            const SizedBox(height: 50),
            ListTile(
              leading: const Icon(Iconsax.user_outline),
              title: const Text('My Profile'),
              trailing: const Icon(Iconsax.arrow_right_outline),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (BuildContext context) =>
                          ProfileEditScreenController(context),
                      child: const ProfileEditScreen(),
                    ),
                  ),
                );
              },
            ),
            const ListTile(
              leading: Icon(Iconsax.lock_1_outline),
              title: Text('Change Password'),
              trailing: Icon(Iconsax.arrow_right_outline),
            ),
            ListTile(
              leading: const Icon(Iconsax.location_outline),
              title: const Text('My Addresses'),
              trailing: const Icon(Iconsax.arrow_right_outline),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddressesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Iconsax.box_1_outline),
              title: const Text('My Orders'),
              trailing: const Icon(Iconsax.arrow_right_outline),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => OrdersScreenController(),
                      child: const OrdersScreen(),
                    ),
                  ),
                );
              },
            ),
            const ListTile(
              leading: Icon(Iconsax.info_circle_outline),
              title: Text('About us'),
              trailing: Icon(Iconsax.arrow_right_outline),
            ),
            const ListTile(
              leading: Icon(Iconsax.star_outline),
              title: Text('Rate us on Play Store'),
              trailing: Icon(Iconsax.arrow_right_outline),
            ),
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false,
                );
              },
              leading: const Icon(
                Iconsax.logout_outline,
                color: ColorConstants.primaryRed,
              ),
              title: const Text(
                'Log out',
                style: TextStyle(color: ColorConstants.primaryRed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
