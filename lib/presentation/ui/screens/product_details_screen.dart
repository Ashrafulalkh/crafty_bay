import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/reviews_screen.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductImageSlider(sliderUrls: [
            productDetails.img1!,
            productDetails.img2!,
            productDetails.img3!,
            productDetails.img4!,
          ],),
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
                  size: productDetails.color!.split(','),
                  onSizeSelected: (String selectSize) {},
                ),
                const SizedBox(
                  height: 8,
                ),
                SizePicker(
                  size: productDetails.size!.split(','),
                  onSizeSelected: (String selectSize) {},
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
          initialValue: 1,
          minValue: 1,
          maxValue: 10,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {},
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
            Get.to(() => const ReviewsScreen());
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
        Card(
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
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add To Cart'),
            ),
          )
        ],
      ),
    );
  }
}
