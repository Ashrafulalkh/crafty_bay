import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_list_item_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/Snack_bar.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/cart_item_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  @override
  void initState() {
    super.initState();
    Get.find<CartListController>().getCartList();
  }

  double get totalPrice {
    final cartListController = Get.find<CartListController>();
    return cartListController.cartListData.fold(0.0, (sum, item) {
      final quantity = int.parse(item.qty ?? '1');
      final price =
          double.tryParse(item.price.toString()) ?? 0.0; // Safely handle price
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<CartListController>(builder: (cartListController) {
          // Check if the cart is being loaded
          if (cartListController.inProgress) {
            return const CenterCircularProgressIndicator();
          }

          // Check if the cart list is empty
          if (cartListController.cartListData.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // Display the list of cart items
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartListController.cartListData.length,
                  itemBuilder: (context, index) {
                    final cartListData =
                    cartListController.cartListData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                                () => ProductDetailsScreen(
                                productId: cartListData.productId!),
                          );
                        },
                        child: CartItemWidget(
                          cartListData: cartListData,
                          onQuantityChanged: (newQuantity) {
                            setState(() {
                              cartListData.qty = newQuantity.toString();
                            });
                          },
                          onDelete: () async {
                            final cartItemId = cartListData.productId;

                            // Attempt to delete the item
                            bool success =
                            await Get.find<DeleteCartListItemController>()
                                .deleteCartItem(cartItemId!);

                            if (success) {
                              // Optionally refresh the cart list
                              await Get.find<CartListController>()
                                  .getCartList();
                            } else {
                              failedSnackbarMassage(
                                  'Delete Item',
                                  'Item cannot be deleted! Please try again');
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              _buildPriceAndAddToCartSection(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(9),
          topRight: Radius.circular(9),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Price'),
              Text(
                '\$$totalPrice',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {
                // Handle checkout action
              },
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
