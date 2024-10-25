import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_wishList-controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/reviews_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/Snack_bar.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_image_slider.dart';
import 'package:crafty_bay/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String _selectColor = '';
  String _selectSize = '';
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        if (productDetailsController.errorMassage != null) {
          return Center(
            child: Text(productDetailsController.errorMassage!),
          );
        }
        return Column(
          children: [
            Expanded(
              child: _buildProductDetails(
                productDetailsController.productModel!,
              ),
            ),
            _buildPriceAndAddToCartSection(
              productDetailsController.productModel!,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProductDetails(ProductDetailsModel productDetails) {
    List<String> colors = productDetails.color!.split(',');
    List<String> sizes = productDetails.size!.split(',');
    _selectSize = sizes.first;
    _selectColor = colors.first;
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(
            sliderUrls: [
              productDetails.img1!,
              productDetails.img2!,
              productDetails.img3!,
              productDetails.img4!,
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNameAndQuantitySection(productDetails),
                _buildRatingAndReviewSection(productDetails),
                const SizedBox(
                  height: 8,
                ),
                // ColorPicker(colors: const [
                //   Colors.black,
                //   Colors.lightBlueAccent,
                //   Colors.brown,
                //   Colors.red,
                //   Colors.grey,
                // ], onColorSelected: (color) {}),
                SizePicker(
                  size: colors,
                  onSizeSelected: (String selectColor) {
                    _selectColor = selectColor;
                  },
                  title: 'Colors',
                ),
                const SizedBox(
                  height: 8,
                ),
                SizePicker(
                  size: sizes,
                  onSizeSelected: (String selectSize) {
                    _selectSize = selectSize;
                  },
                  title: 'Size',
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildDescriptionSection(productDetails),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(ProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          productDetails.product!.shortDes ?? '',
          style: const TextStyle(color: Colors.black45),
        ),
      ],
    );
  }

  Widget _buildNameAndQuantitySection(ProductDetailsModel productDetails) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            productDetails.product?.title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ItemCount(
          initialValue: quantity,
          minValue: 1,
          maxValue: 10,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {
            quantity = value.toInt();
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildRatingAndReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text(
              productDetails.product?.star.toString() ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        TextButton(
          onPressed: () {
            Get.to(
              () => ReviewsScreen(
                id: widget.productId,
              ),
            );
          },
          child: const Text(
            'Reviews',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GetBuilder<AddToWishListController>(
          builder: (addToWishListController) {
            return Visibility(
              visible: !addToWishListController.inProgress,
              replacement: const CenterCircularProgressIndicator(),
              child: GestureDetector(
                onTap: () {
                  _onTapFavouriteButton();
                },
                child: Card(
                  color: AppColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.favorite,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ],
    );
  }

  Widget _buildPriceAndAddToCartSection(ProductDetailsModel productDetails) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(9),
            topRight: Radius.circular(9),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              Text(
                '\$${productDetails.product?.price ?? ''}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child:
                GetBuilder<AddToCartController>(builder: (addToCartController) {
              return Visibility(
                visible: !addToCartController.inProgress,
                replacement: const CenterCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () {
                    _onTapAddToCart();
                  },
                  child: const Text('Add To Cart'),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  void _onTapAddToCart() async {
    bool result = Get.find<AuthController>().isLoggedIn();
    if (result) {
      final bool addToCartResult =
          await Get.find<AddToCartController>().addToCart(
        widget.productId,
        _selectColor,
        _selectSize,
        quantity,
      );
      if (addToCartResult) {
        successSnackbarMassage(
            'Add To Cart', 'Product successfully added to the cart');
      } else {
        failedSnackbarMassage('Add To Cart',
            'Product can not added to the cart!! Please Try Again');
      }
    } else {
      Get.to(() => const EmailVerificationScreen());
    }
  }

  Future<void> _onTapFavouriteButton() async{
    final bool result = await Get.find<AddToWishListController>().addToWishList(widget.productId);
    if(result) {
      successSnackbarMassage('Wish List', 'The product is successfully added to WishList');
    }else {
      failedSnackbarMassage('Wish List', 'Failed to add wishlist!! Try again');

    }
  }

}
