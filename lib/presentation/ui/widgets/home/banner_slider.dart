import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/data/models/slider_model.dart';
import 'package:crafty_bay/presentation/state_holders/slider_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerSilder extends StatefulWidget {
  const BannerSilder({
    super.key,
  });

  @override
  State<BannerSilder> createState() => _BannerSilderState();
}

class _BannerSilderState extends State<BannerSilder> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SliderListController>(builder: (sliderListController) {
      return Visibility(
        visible: !sliderListController.inProgress,
        replacement: const SizedBox(
          height: 192,
          child: CenterCircularProgressIndicator(),
        ),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  _selectedIndex.value = index;
                },
              ),
              items: sliderListController.sliderList.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.network(
                              height: 180,
                              width: double.infinity,
                              slider.image ?? '',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 40,
                            child: _buildSliderProductTitleAndButton(
                                context, slider),
                          )
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(
              height: 6,
            ),
            ValueListenableBuilder(
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
                            color:
                                currentIndex == i ? AppColors.themeColor : null,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                    ],
                  );
                })
          ],
        ),
      );
    });
  }

  Widget _buildSliderProductTitleAndButton(
      BuildContext context, SliderModel slider) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      // Ensures button fits within the screen width
      padding: const EdgeInsets.all(6.0),
      // Padding around text and button
      decoration: BoxDecoration(
        // Semi-transparent background for better readability
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slider.title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.themeColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 6.0,
              ),
            ),
            child: const Text('Shop Now'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }
}
