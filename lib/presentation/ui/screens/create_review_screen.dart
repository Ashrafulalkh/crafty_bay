import 'package:flutter/material.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _firtNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          children: [
            TextFormField(
              controller: _firtNameController,
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                hintText: 'Last Name',
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            TextFormField(
              controller: _reviewController,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: 'Write Review',
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firtNameController.dispose();
    _lastNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
