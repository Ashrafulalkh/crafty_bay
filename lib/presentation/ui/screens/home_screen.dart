import 'package:crafty_bay/presentation/state_holders/bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utils/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:crafty_bay/presentation/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              SearchTextField(
                searchController: TextEditingController(),
              ),
              const SizedBox(
                height: 16,
              ),
              const BannerSilder(),
              const SizedBox(
                height: 16,
              ),
              _buildCategoriesSection(),
              _buildPopularProductSection(),
              const SizedBox(
                height: 16,
              ),
              _buildNewProductSection(),
              const SizedBox(
                height: 16,
              ),
              _buildSpecialProductSection(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularProductSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Popular',
          onTap: () {},
        ),
        const SizedBox(height: 180, child: HorizontalProductListView(prodcutList: [],)),
      ],
    );
  }

  Widget _buildNewProductSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'New',
          onTap: () {},
        ),
         SizedBox(height: 180, child: GetBuilder<ProductListController>(
           builder: (productListController) {
             return Visibility(
               visible: !productListController.inProgress,
                 replacement: const CenterCircularProgressIndicator(),
                 child:  HorizontalProductListView(prodcutList: productListController.productList,),);
           }
         ),),
      ],
    );
  }

  Widget _buildSpecialProductSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Special',
          onTap: () {},
        ),
        const SizedBox(height: 180, child: HorizontalProductListView(prodcutList: [],)),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Categories',
          onTap: () {
            Get.find<BottomNavBarController>().selectCategory();
          },
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 120,
          child: GetBuilder<CategoryListController>(
              builder: (categoryListController) {
            return Visibility(
              visible: !categoryListController.inProgress,
              replacement: const CenterCircularProgressIndicator(),
              child: HorizontalCategoryListView(
                categoryList: categoryListController.categoryList,
              ),
            );
          }),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: SvgPicture.asset(AssetsPath.applogoNav),
      actions: [
        AppBarIconButton(
          iconData: Icons.person,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
        AppBarIconButton(
          iconData: Icons.call,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
        AppBarIconButton(
          iconData: Icons.notifications,
          onTap: () {},
        ),
      ],
    );
  }
}
