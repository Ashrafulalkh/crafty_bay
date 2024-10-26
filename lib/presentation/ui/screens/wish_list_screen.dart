import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_wish_list_item_controller.dart';
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
          title: const Text('Wish List'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: GetBuilder<WishListController>(builder: (wishListController) {
          // Check if the wish list is being loaded
          if (wishListController.inProgress) {
            return const CenterCircularProgressIndicator();
          }

          // Check if the wish list is empty
          if (wishListController.wishListData.isEmpty) {
            return const Center(
              child: Text(
                'Your wish list is empty',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          // Display the list of wish list items
          return ListView.builder(
            itemCount: wishListController.wishListData.length,
            itemBuilder: (context, index) {
              final wishListData = wishListController.wishListData[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProductDetailsScreen(
                        productId: wishListData.productId!));
                  },
                  child: WishListItemWidget(
                    onDelete: () async {
                      final wishListItemId = wishListData.productId;

                      // Attempt to delete the item
                      bool success =
                          await Get.find<DeleteWishListItemController>()
                              .deleteWishListItem(wishListItemId!);

                      if (success) {
                        // Refresh the wish list
                        await Get.find<WishListController>().getWishList();
                      } else {
                        failedSnackbarMassage('Delete Item',
                            'Item cannot be deleted! Please try again');
                      }
                    },
                    wishListData: wishListData,
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
