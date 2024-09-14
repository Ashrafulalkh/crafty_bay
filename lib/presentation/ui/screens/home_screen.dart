import 'package:crafty_bay/presentation/ui/screens/category_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/assets_path.dart';
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
        const SizedBox(height: 180, child: HorizontalProductListView()),
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
        const SizedBox(height: 180, child: HorizontalProductListView()),
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
        const SizedBox(height: 180, child: HorizontalProductListView()),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      children: [
        SectionHeader(
          title: 'Categories',
          onTap: () {
            Get.to(() => const CategoryListScreen());
          },
        ),
        const SizedBox(
          height: 8,
        ),
        const SizedBox(
          height: 120,
          child: HorizontalCategoryListView(),
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