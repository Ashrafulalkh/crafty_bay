import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controllers/auth_controller.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage = '';
  bool _isProfileCompleted = false;

  String? get errorMassage => _errorMassage;

  bool get inProgress => _inProgress;

  bool get isProfileCompleted => _isProfileCompleted;


  Future<bool> getProfileDetails(String token) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.readProfileDetailsUrl,token: token);

    if(response.isSuccess) {
      if(response.responseData['data'] != null) {
        _isProfileCompleted = true;
        await Get.find<AuthController>().saveAccessToken(token);
      }
      isSuccess = true;
      _errorMassage = null;
    }else {
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;

  }

}