import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextTheme textTheme = Theme.of(context).textTheme;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          leading: IconButton(
            onPressed: backToHome,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: CartItemWidget(),
                  );
                },
              ),
            ),
            _buildPriceAndAddToCartSection(),
          ],
        ),
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
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Price'),
              Text(
                '\$120000',
                style: TextStyle(
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
              onPressed: () {},
              child: const Text('Checkout'),
            ),
          )
        ],
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Row(
        children: [
          Image.asset(
            height: 80,
            width: 80,
            AssetsPath.dummyProductImg,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title of Product',
                            style: textTheme.bodyLarge,
                          ),
                          Wrap(
                            spacing: 8,
                            children: [
                              Text(
                                'Color : Red',
                                style: textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                              Text(
                                'Size : XL',
                                style: textTheme.bodySmall
                                    ?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$100',
                      style: textTheme.titleMedium?.copyWith(
                        color: AppColors.themeColor,
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
