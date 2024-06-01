import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/controller/screens/add_address_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/view/add_address_screen/add_address_screen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import 'widgets/address_card.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My addresses'),
        backgroundColor: ColorConstants.primaryWhite,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorConstants.primaryBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
              child: Consumer<FireStoreController>(
                builder: (context, provider, child) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var address = provider.addressList[index];
                      return AddressCard(
                        address: address,
                        isDefault: address.collectionDocumentId ==
                            provider.defaultAddressId,
                        onEditPressed: () {},
                        onDeletePressed: () {
                          provider.deleteAddress(address);
                        },
                        onTap: () {
                          provider.setDefaultAddress(address);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemCount: provider.addressList.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
