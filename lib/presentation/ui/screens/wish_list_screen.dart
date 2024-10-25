import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_list_item_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/Snack_bar.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/wish_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late TextTheme textTheme = Theme.of(context).textTheme;

  @override
  void initState() {
    super.initState();
    Get.find<WishListController>().getWishList();
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
        body: GetBuilder<WishListController>(builder: (wishListController) {
          return Visibility(
            visible: !wishListController.inProgress,
            replacement: const CenterCircularProgressIndicator(),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: wishListController.wishListData.length,
                    itemBuilder: (context, index) {
                      final wishListData =
                          wishListController.wishListData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                () => ProductDetailsScreen(productId: index));
                          },
                          child: WishListtemWidget(
                            onDelete: () async {
                              bool success =
                                  await Get.find<DeleteCartListItemController>()
                                      .deleteCartItem(index);
                              if (success) {
                                wishListController.wishListData
                                    .removeAt(index); // Remove from local list
                                wishListController
                                    .update(); // Update the controller
                              } else {
                                failedSnackbarMassage('Delete Item',
                                    'Item can not deleted!! Please try again');
                              }
                            },
                            wishListData: wishListData,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
