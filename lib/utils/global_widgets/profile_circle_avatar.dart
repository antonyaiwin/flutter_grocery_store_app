import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firebase_auth_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:provider/provider.dart';

class ProfileCircleAvatar extends StatelessWidget {
  const ProfileCircleAvatar({
    super.key,
    this.radius,
  });
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ColorConstants.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(radius ?? 22),
      ),
      child: Consumer<FirebaseAuthController>(
        builder: (context, auth, child) => auth.currentUser?.photoURL != null
            ? MyNetworkImage(
                imageUrl: auth.currentUser!.photoURL!,
                height: (radius ?? 22) * 2,
                width: (radius ?? 22) * 2,
                fit: BoxFit.cover,
              )
            : auth.currentUser?.displayName == null
                ? SizedBox(
                    height: (radius ?? 22) * 2,
                    width: (radius ?? 22) * 2,
                  )
                : SizedBox(
                    height: (radius ?? 22) * 2,
                    width: (radius ?? 22) * 2,
                    child: Center(
                      child: Text(
                        auth.currentUser?.displayName != null &&
                                auth.currentUser!.displayName!.isNotEmpty
                            ? auth.currentUser!.displayName![0]
                            : 'U',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
      ),
    );
  }
}
