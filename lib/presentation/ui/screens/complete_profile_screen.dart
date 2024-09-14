import 'package:crafty_bay/presentation/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              const AppLogo(),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Get start with us by providing your informations ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _firstNameController,
                decoration: const InputDecoration(hintText: 'First Name'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: 'Last Name'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                controller: _mobileController,
                decoration: const InputDecoration(hintText: 'Mobile Number'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _cityController,
                decoration: const InputDecoration(hintText: 'City'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLines: 4,
                controller: _addressController,
                decoration: const InputDecoration(hintText: 'Shipping Address'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Complete'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapCompleteButton() {
  }


  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
