import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

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
          _buildProductImage(),
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
                          _buildColorAndSize(textTheme),
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
                _buildPriceAndCounter(textTheme)
              ],
            ),
          )
        ],
      ),
    );
  }

  Wrap _buildColorAndSize(TextTheme textTheme) {
    return Wrap(
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
                        );
  }

  Widget _buildPriceAndCounter(TextTheme textTheme) {
    return Row(
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
              );
  }

  Widget _buildProductImage() {
    return Image.asset(
          height: 80,
          width: 80,
          AssetsPath.dummyProductImg,
          fit: BoxFit.scaleDown,
        );
  }
}