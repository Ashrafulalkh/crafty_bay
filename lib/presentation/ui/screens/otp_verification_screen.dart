import 'package:crafty_bay/presentation/state_holders/auth_controllers/otp_verification_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/read_profile_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utils/Snack_bar.dart';
import 'package:crafty_bay/presentation/ui/utils/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:crafty_bay/presentation/ui/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final OtpVerificationController _otpVerificationController =
      Get.find<OtpVerificationController>();
  final ReadProfileController _readProfileController = Get.find<ReadProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
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
                'Enter OTP Code',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'A 4 digit OTP has been sent to email',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black54,
                    ),
              ),
              const SizedBox(
                height: 16,
              ),
              PinCodeTextField(
                length: 6,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  selectedColor: Colors.green,
                  inactiveFillColor: Colors.white,
                  inactiveColor: AppColors.themeColor,
                ),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: _otpController,
                appContext: context,
              ),
              const SizedBox(
                height: 24,
              ),
              GetBuilder<OtpVerificationController>(
                  builder: (otpVerificationController) {
                return Visibility(
                  visible: !otpVerificationController.inProgress,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      _onTapNextButton();
                    },
                    child: const Text('Next'),
                  ),
                );
              }),
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                  text: 'The Code Will Expire in ',
                  children: const [
                    TextSpan(
                      text: '120s',
                      style: TextStyle(color: AppColors.themeColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Resend Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    bool result = await _otpVerificationController.verifyOtpEmail(
      widget.email,
      _otpController.text,
    );
    if (result) {
      final bool readProfileResult = await _readProfileController.getProfileDetails(_otpVerificationController.accessToken);
      if(readProfileResult){
        if(_readProfileController.isProfileCompleted){
          Get.offAll(() => const MainBottomNavScreen());
        }else {
          Get.to(() => const CompleteProfileScreen());
        }
      }else {
        failedSnackbarMassage(
          'Read profile data',
          'Read profile data failed!! Please Try again',
        );
      }
      successSnackbarMassage(
        'OTP Verification',
        'OTP verication successfully done',
      );
    } else {
      failedSnackbarMassage(
        'OTP Verification',
        'OTP verification failed!! Please Try again',
      );
    }
  }
}
