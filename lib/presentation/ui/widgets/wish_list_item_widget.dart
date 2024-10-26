import 'package:crafty_bay/data/models/cart_list_data_model.dart';
import 'package:crafty_bay/data/models/wish_list_data_model.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class WishListItemWidget extends StatelessWidget {
  const WishListItemWidget({
    super.key,
    required this.onDelete,
    required this.wishListData,
  });

  final WishListDataModel wishListData;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    late TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Row(
        children: [
          _buildProductImage(),
          const SizedBox(width: 12),
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
                            wishListData.product?.title ?? 'Unknown',
                            style: textTheme.bodyLarge,
                          ),
                          // _buildColorAndSize(textTheme),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, color: Colors.grey),
                    ),
                  ],
                ),
                _buildPriceAndCounter(textTheme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildColorAndSize(TextTheme textTheme) {
  //   return Wrap(
  //     spacing: 8,
  //     children: [
  //       Text(
  //         'Color : ${wishListData.product.shortDes}',
  //         style: textTheme.bodySmall?.copyWith(color: Colors.grey),
  //       ),
  //       Text(
  //         'Size : ${cartListData.size}',
  //         style: textTheme.bodySmall?.copyWith(color: Colors.grey),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildPriceAndCounter(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${wishListData.product?.price}',
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.themeColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return Image.network(
      height: 80,
      width: 80,
      wishListData.product?.image ?? 'Unknown',
      fit: BoxFit.scaleDown,
    );
  }
}
