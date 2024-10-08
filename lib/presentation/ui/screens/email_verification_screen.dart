import 'package:crafty_bay/presentation/state_holders/auth_controllers/email_verification_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/otp_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();

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
                  height: 80,
                ),
                const AppLogo(),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Please Enter Your Email Address',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black54,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      //TODO: verify email through regx
                      return 'Enter a valid Email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<EmailVerificationController>(
                  builder: (emailVerificationController) {
                    return Visibility(
                      visible: !emailVerificationController.inProgress,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapNextButton();
                        },
                        child: const Text('Next'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await _emailVerificationController
        .verifyEmail(_emailController.text.trim());

    if(result) {
      Get.to(() => const OtpVerificationScreen());
    }else {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Verify Email Error',
          message: 'Something Went Wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
