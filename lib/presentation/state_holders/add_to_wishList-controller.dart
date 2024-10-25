import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class AddToWishListController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  Future<bool> addToWishList(
    int id,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.addtoWishListUrl(id),
    );

    if (response.isSuccess) {
      _errorMassage = null;
      isSuccess = true;
    } else {
      _errorMassage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
