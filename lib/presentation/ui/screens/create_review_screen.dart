import 'package:crafty_bay/presentation/state_holders/create_reiew_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/reviews_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/Snack_bar.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.id});

  final int id;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter valid rating';
                  }
                  return null;
                },
                controller: _ratingController,
                decoration: const InputDecoration(
                  hintText: 'Rating',
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              TextFormField(
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter valid Review';
                  }
                  return null;
                },
                controller: _reviewController,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: 'Write Review',
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GetBuilder<CreateReiewController>(
                builder: (createReviewController) {
                  return Visibility(
                    visible: !createReviewController.inProgress,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        _onTapSubmitButton();
                      },
                      child: const Text('Submit'),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSubmitButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final int rating = int.parse(_ratingController.text.trim());
    final String review = _reviewController.text.trim();
    final bool result = await Get.find<CreateReiewController>().createReview(widget.id,rating, review);

    if (result) {
      Get.back();
      successSnackbarMassage('Add Review', 'Review Added Successfully');
    } else {
      failedSnackbarMassage(
          'Add Review', 'Add review failed!! Please try again');
    }
  }

  @override
  void dispose() {
    _ratingController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
