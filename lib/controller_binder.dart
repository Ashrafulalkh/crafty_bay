import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_wishList-controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/email_verification_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/otp_verification_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/read_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/create_reiew_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_list_item_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_wish_list_item_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/reviews_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'presentation/state_holders/category_list_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavBarController());
    Get.put(Logger());
    Get.put(AuthController());
    Get.put(NetworkCaller(
      logger: Get.find<Logger>(),
      authController: Get.find<AuthController>(),
    ));
    Get.put(SliderListController());
    Get.put(CategoryListController());
    Get.put(NewProductListController());
    Get.put(PopularProductListController());
    Get.put(SpecialProductListController());
    Get.put(ProductListByCategoryController());
    Get.put(ProductDetailsController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(ReadProfileController());
    Get.put(AddToCartController());
    Get.put(CompleteProfileController());
    Get.put(ReviewsListController());
    Get.put(CreateReiewController());
    Get.put(CartListController());
    Get.put(DeleteCartListItemController());
    Get.put(AddToWishListController());
    Get.put(WishListController());
    Get.put(DeleteWishListItemController());
  }
}
