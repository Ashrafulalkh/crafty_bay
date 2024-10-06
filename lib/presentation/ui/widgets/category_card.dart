import 'package:crafty_bay/data/models/category_model.dart';
import 'package:crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () =>
              ProductListScreen(category: categoryModel),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                height: 70,
                child: Image.network(
                  categoryModel.categoryImg ?? '',
                  fit: BoxFit.scaleDown,
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            categoryModel.categoryName ?? '',
            style: const TextStyle(color: AppColors.themeColor),
          ),
        ],
      ),
    );
  }
}
