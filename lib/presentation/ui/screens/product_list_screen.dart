import 'package:crafty_bay/data/models/category_model.dart';
import 'package:crafty_bay/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>()
        .getProductByCategory(widget.category.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.categoryName ?? ''),
      ),
      body: GetBuilder<ProductListByCategoryController>(
          builder: (productListByCategoryController) {
        if (productListByCategoryController.inProgress) {
          return const CenterCircularProgressIndicator();
        }
        if (productListByCategoryController.errorMassage != null) {
          return Center(
            child: Text(productListByCategoryController.errorMassage!),
          );
        }
        if(productListByCategoryController.productList.isEmpty){
          return const Center(
            child: Text('Product list is empty!'),
          );
        }
        return GridView.builder(
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 12,
            crossAxisSpacing: 6,
          ),
          itemBuilder: (context, index) {
            return FittedBox(
                child: ProductCard(
              product: productListByCategoryController.productList[index],
            ));
          },
        );
      }),
    );
  }
}
