import 'package:crafty_bay/data/models/cart_list_data_model.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.cartListData,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  final CartListDataModel cartListData;
  final ValueChanged<int> onQuantityChanged; // Accepts int now
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
                            cartListData.product?.title ?? 'Unknown',
                            style: textTheme.bodyLarge,
                          ),
                          _buildColorAndSize(textTheme),
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

  Widget _buildColorAndSize(TextTheme textTheme) {
    return Wrap(
      spacing: 8,
      children: [
        Text(
          'Color : ${cartListData.color}',
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
        Text(
          'Size : ${cartListData.size}',
          style: textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPriceAndCounter(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$${cartListData.price}',
          style: textTheme.titleMedium?.copyWith(
            color: AppColors.themeColor,
          ),
        ),
        ItemCount(
          initialValue: int.parse(cartListData.qty ?? '1'),
          minValue: 1,
          maxValue: 10,
          decimalPlaces: 0,
          color: AppColors.themeColor,
          onChanged: (value) {
            onQuantityChanged(value.toInt()); // Ensure this is an int
          },
        ),
      ],
    );
  }

  Widget _buildProductImage() {
    return Image.network(
      height: 80,
      width: 80,
      cartListData.product?.image ?? 'Unknown',
      fit: BoxFit.scaleDown,
    );
  }
}
