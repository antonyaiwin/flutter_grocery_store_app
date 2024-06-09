import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/cart_controller.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/core/constants/image_constants.dart';
import 'package:flutter_grocery_store/view/addresses_screen/widgets/address_card.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/bill_details_card.dart';
import 'package:flutter_grocery_store/view/order_success_screen/order_success_screen.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../utils/functions/widget_route_functions.dart';
import '../../utils/global_widgets/subtitle_text.dart';
import 'widgets/address_select_bottom_sheet.dart';
import 'widgets/payment_method_card.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SubtitleText(
                    text: 'Delivering to',
                  ),
                  const SizedBox(height: 10),
                  Consumer2<FireStoreController, CartController>(
                    builder: (context, firestore, cart, child) {
                      if (cart.selectedAddress == null) {
                        return GestureDetector(
                          onTap: () {
                            _showAddressBottomSheet(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryWhite,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Text(
                                  'Address not selected. Click to select.'),
                            ),
                          ),
                        );
                      }
                      return AddressCard(
                        address: cart.selectedAddress!,
                        isDefault: false,
                        displayChangeButton: true,
                        onChangePressed: () {
                          _showAddressBottomSheet(context);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  const SubtitleText(text: 'Payment Method'),
                  const SizedBox(height: 10),
                  Consumer<CartController>(
                    builder: (BuildContext context, CartController cart,
                            Widget? child) =>
                        PaymentMethodCard(
                      name: 'Razorpay (Online)',
                      isSelected: cart.selectedPaymentMethod == 'razorpay',
                      child: Image.asset(ImageConstants.razorpayLogo),
                      onTap: () {
                        cart.setPaymentMethod('razorpay');
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Consumer<CartController>(
                    builder: (BuildContext context, CartController cart,
                            Widget? child) =>
                        PaymentMethodCard(
                      name: 'Cash on Delivery (COD)',
                      isSelected: cart.selectedPaymentMethod == 'cod',
                      child: const Icon(
                        Iconsax.moneys_outline,
                        size: 26,
                      ),
                      onTap: () {
                        cart.setPaymentMethod('cod');
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SubtitleText(text: 'Order Summary'),
                  const SizedBox(height: 10),
                  Consumer<CartController>(
                    builder: (context, cart, child) {
                      return BillDetailsCard(
                        totalItems: cart.totalCartCount,
                        subtotal: cart.totalCartPrice,
                        deliveryCharge: 20.0,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<CartController>(
              builder: (context, cart, child) {
                return ElevatedButton(
                  onPressed: !cart.canCheckout() || cart.creatingOrder
                      ? null
                      : () async {
                          var order = await cart.placeOrder(context);
                          if (order != null && context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderSuccessScreen(
                                  order: order,
                                ),
                              ),
                            );
                          }
                        },
                  child: Center(
                    child: cart.creatingOrder
                        ? const SizedBox(
                            height: 19,
                            width: 19,
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            cart.selectedPaymentMethod != 'razorpay'
                                ? 'Place Order'
                                : 'Goto Payment',
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    showMyModalBottomSheet(
      context: context,
      expand: false,
      isScrollControlled: true,
      initialChildSize: 0.75,
      minChildSize: 0.75,
      builder: (context, scrollController) {
        return const AddressSelectBottomSheetContent(
          scrollController: null,
        );
      },
    );
  }
}
