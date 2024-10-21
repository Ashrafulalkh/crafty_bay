import 'package:crafty_bay/presentation/state_holders/auth_controllers/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/Snack_bar.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _cusNameController = TextEditingController();
  final TextEditingController _cusAddressController = TextEditingController();
  final TextEditingController _cusFaxController = TextEditingController();
  final TextEditingController _cusNumberController = TextEditingController();
  final TextEditingController _cusCityController = TextEditingController();
  final TextEditingController _cusStateController = TextEditingController();
  final TextEditingController _cusPostCodeController = TextEditingController();
  final TextEditingController _cusCountryController = TextEditingController();
  final TextEditingController _shipNameController = TextEditingController();
  final TextEditingController _shipPhoneController = TextEditingController();
  final TextEditingController _shipCityController = TextEditingController();
  final TextEditingController _shipStateController = TextEditingController();
  final TextEditingController _shipPostCodeController = TextEditingController();
  final TextEditingController _shipCountryController = TextEditingController();
  final TextEditingController _shipAddressController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Form(
            key: _formKey,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                  controller: _cusNameController,
                  decoration: const InputDecoration(hintText: 'Customer Name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Address';
                    }
                    return null;
                  },
                  controller: _cusAddressController,
                  decoration:
                      const InputDecoration(hintText: 'Customer Address'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Fax';
                    }
                    return null;
                  },
                  controller: _cusFaxController,
                  decoration: const InputDecoration(hintText: 'Customer Fax'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: _cusNumberController,
                  decoration:
                      const InputDecoration(hintText: 'Customer Number'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid City';
                    }
                    return null;
                  },
                  controller: _cusCityController,
                  decoration: const InputDecoration(hintText: 'Customer City'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid State';
                    }
                    return null;
                  },
                  controller: _cusStateController,
                  decoration: const InputDecoration(hintText: 'Customer State'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid PostCode';
                    }
                    return null;
                  },
                  controller: _cusPostCodeController,
                  decoration:
                      const InputDecoration(hintText: 'Customer PostCode'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Country';
                    }
                    return null;
                  },
                  controller: _cusCountryController,
                  decoration:
                      const InputDecoration(hintText: 'Customer Country'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Name';
                    }
                    return null;
                  },
                  controller: _shipNameController,
                  decoration: const InputDecoration(hintText: 'Ship Name'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Phone';
                    }
                    return null;
                  },
                  controller: _shipPhoneController,
                  decoration: const InputDecoration(hintText: 'Ship Phone'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid City';
                    }
                    return null;
                  },
                  controller: _shipCityController,
                  decoration: const InputDecoration(hintText: 'Ship City'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid State';
                    }
                    return null;
                  },
                  controller: _shipStateController,
                  decoration: const InputDecoration(hintText: 'Ship State'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid PostCode';
                    }
                    return null;
                  },
                  controller: _shipPostCodeController,
                  decoration: const InputDecoration(hintText: 'Ship PostCode'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Country';
                    }
                    return null;
                  },
                  controller: _shipCountryController,
                  decoration: const InputDecoration(hintText: 'Ship Country'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  maxLines: 4,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter valid Address';
                    }
                    return null;
                  },
                  controller: _shipAddressController,
                  decoration:
                      const InputDecoration(hintText: 'Shipping Address'),
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<CompleteProfileController>(
                  builder: (compleProfileController) {
                    return Visibility(
                      visible: !compleProfileController.inProgress,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapCompleteButton();
                        },
                        child: const Text('Complete'),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapCompleteButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final bool result =
        await Get.find<CompleteProfileController>().completeProfile(
      _cusNameController.text.trim(),
      _cusAddressController.text.trim(),
      _cusFaxController.text.trim(),
      _cusNumberController.text.trim(),
      _cusCityController.text.trim(),
      _cusStateController.text.trim(),
      _cusPostCodeController.text.trim(),
      _cusCountryController.text.trim(),
      _shipNameController.text.trim(),
      _shipPhoneController.text.trim(),
      _shipCityController.text.trim(),
      _shipPostCodeController.text.trim(),
      _shipCountryController.text.trim(),
      _shipAddressController.text.trim(),
      _shipStateController.text.trim(),
    );
    if(result) {
      Get.offAll(() => const MainBottomNavScreen());
      successSnackbarMassage('ComPlete Profile', 'Profile Completed Successfully');
    }else {
      failedSnackbarMassage('Completed Profile', 'Profile Completion failed!! Please try again');
    }

  }

  @override
  void dispose() {
    _cusNameController.dispose();
    _cusAddressController.dispose();
    _cusFaxController.dispose();
    _cusNumberController.dispose();
    _cusCityController.dispose();
    _cusStateController.dispose();
    _cusPostCodeController.dispose();
    _cusCountryController.dispose();
    _shipNameController.dispose();
    _shipPhoneController.dispose();
    _shipCityController.dispose();
    _shipStateController.dispose();
    _shipPostCodeController.dispose();
    _shipCountryController.dispose();
    _shipAddressController.dispose();
    super.dispose();
  }
}
