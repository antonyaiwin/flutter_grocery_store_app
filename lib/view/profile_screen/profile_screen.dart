import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/profile_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/global_widgets/elevated_card.dart';
import 'package:flutter_grocery_store/utils/global_widgets/profile_circle_avatar.dart';
import 'package:flutter_grocery_store/view/splash_screen/splash_screen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

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
            GestureDetector(
              onTap: () {
                context.read<ProfileScreenController>().changeProfilePic();
              },
              child: Stack(
                children: [
                  Consumer<ProfileScreenController>(
                    builder: (context, value, child) => ProfileCircleAvatar(
                      radius: 70,
                      user: value.currentUser,
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedCard(
                      padding: EdgeInsets.zero,
                      elevation: 1,
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              FirebaseAuth.instance.currentUser?.displayName ?? '',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorConstants.hintColor,
                  ),
            ),
            const SizedBox(height: 50),
            const ListTile(
              leading: Icon(Iconsax.user_outline),
              title: Text('My Profile'),
              trailing: Icon(Iconsax.arrow_right_outline),
            ),
            const ListTile(
              leading: Icon(Iconsax.lock_1_outline),
              title: Text('Change Password'),
              trailing: Icon(Iconsax.arrow_right_outline),
            ),
            const ListTile(
              leading: Icon(Iconsax.location_outline),
              title: Text('My Addresses'),
              trailing: Icon(Iconsax.arrow_right_outline),
            ),
            const ListTile(
              leading: Icon(Iconsax.box_1_outline),
              title: Text('My Orders'),
              trailing: Icon(Iconsax.arrow_right_outline),
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
