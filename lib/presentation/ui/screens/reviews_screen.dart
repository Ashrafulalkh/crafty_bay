import 'package:crafty_bay/data/models/customer_profile_model.dart';
import 'package:crafty_bay/data/models/review_list_data_model.dart';
import 'package:crafty_bay/presentation/state_holders/reviews_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/create_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.id});

  final int id;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewsListController>().getReviews(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: GetBuilder<ReviewsListController>(builder: (reviewListController) {
        return Visibility(
          visible: !reviewListController.inProgress,
          replacement: const CenterCircularProgressIndicator(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviewListController.reviewList.length,
                  itemBuilder: (context, index) {
                    final review = reviewListController.reviewList[index];
                    return _buildReviewsCardSection(context, review);
                  },
                ),
              ),
              _buildReviewsCountandAddButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReviewsCountandAddButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GetBuilder<ReviewsListController>(builder: (reviewListController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reviews (${reviewListController.reviewList.length})',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black54),
                ),
              ],
            );
          }),
          FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
            onPressed: () {
              Get.to(
                () => CreateReviewScreen(id: widget.id,),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsCardSection(
      BuildContext context, ReviewListDataModel review) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    review.profile?.cusName ?? 'Unknown',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(55, 5, 0, 0),
                child: Text(
                  review.description ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
