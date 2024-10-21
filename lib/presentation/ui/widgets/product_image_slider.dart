import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({
    super.key, required this.sliderUrls,
  });

  final List<String> sliderUrls;

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            height: 220,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
          ),
          items: widget.sliderUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl,),
                      ),
                    ),
                  );
                },
              );
            },
          ).toList(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 12,
          child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (context, currentIndex, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      height: 12,
                      width: 12,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? AppColors.themeColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
