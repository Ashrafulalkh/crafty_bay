import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_image_slider.dart';
import 'package:crafty_bay/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        children: [
          const ProductImageSlider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Nike Show 2024 Latest Model- New Year Special Deal',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    ItemCount(
                      initialValue: 0,
                      minValue: 0,
                      maxValue: 10,
                      decimalPlaces: 0,
                      color: AppColors.themeColor,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text(
                          '3',
                          style: TextStyle(
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
                      onPressed: () {},
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
                ),
                const SizedBox(
                  height: 8,
                ),
                ColorPicker(colors: const [
                  Colors.black,
                  Colors.lightBlueAccent,
                  Colors.brown,
                  Colors.red,
                  Colors.grey,
                ], onColorSelected: (color) {}),
                const SizedBox(
                  height: 8,
                ),
                SizePicker(size: const [
                  'M',
                  'L',
                  'Xl',
                  'XXl',
                ], onSizeSelected: (String selectSize) {},)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ColorPicker extends StatefulWidget {
  const ColorPicker(
      {super.key, required this.colors, required this.onColorSelected});

  final List<Color> colors;
  final Function(Colors) onColorSelected;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _selectColors = widget.colors.first;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          spacing: 8,
          children: widget.colors.map((item) {
            return GestureDetector(
              onTap: () {
                _selectColors = item;
                widget.onColorSelected(item as Colors);
                setState(() {});
              },
              child: CircleAvatar(
                backgroundColor: item,
                radius: 16,
                child: _selectColors == item
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
