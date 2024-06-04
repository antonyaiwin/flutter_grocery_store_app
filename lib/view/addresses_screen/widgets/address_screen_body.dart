import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/cart_controller.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/controller/screens/add_address_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/functions/widget_route_functions.dart';
import 'package:flutter_grocery_store/view/add_address_screen/add_address_screen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import 'address_card.dart';

class AddressScreenBody extends StatelessWidget {
  const AddressScreenBody({
    super.key,
    this.isAddressScreen = true,
    this.scrollController,
  });

  final bool isAddressScreen;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            leading: const Icon(
              Icons.add,
              color: ColorConstants.primaryColor,
            ),
            title: Text(
              'Add new address',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorConstants.primaryColor,
                  ),
            ),
            iconColor: ColorConstants.primaryColor,
            trailing: const Icon(Iconsax.arrow_right_3_outline),
            dense: true,
            tileColor: ColorConstants.primaryWhite,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => AddAddressScreenController(context),
                    child: const AddAddressScreen(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Your saved addresses',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorConstants.hintColor,
                ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer2<FireStoreController, CartController>(
              builder: (context, fireStore, cart, child) {
                return ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    var address = fireStore.addressList[index];
                    return AddressCard(
                      address: address,
                      isDefault: isAddressScreen
                          ? address.collectionDocumentId ==
                              fireStore.defaultAddressId
                          : cart.selectedAddress?.collectionDocumentId ==
                              address.collectionDocumentId,
                      onEditPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => AddAddressScreenController(
                                  context,
                                  savedAddress: address),
                              child: const AddAddressScreen(),
                            ),
                          ),
                        );
                      },
                      onDeletePressed: () {
                        showMyBasicDialog(
                          context,
                          title: 'Sure to delete?',
                          content:
                              'Are you sure to delete this address?.\nYou cannot undo this action!',
                          onYesPressed: (context) async {
                            await fireStore.deleteAddress(address);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          onNoPressed: (context) {
                            Navigator.pop(context);
                          },
                        );
                      },
                      onTap: () {
                        if (isAddressScreen) {
                          try {
                            fireStore.setDefaultAddress(address);
                          } on Exception catch (e) {
                            log(e.toString());
                          }
                        } else {
                          cart.setSelectedAddress(address);
                        }
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: fireStore.addressList.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
