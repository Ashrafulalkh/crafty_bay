import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class DeleteWishListItemController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteWishListItem(int id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.deleteWishListUrl(id));

    if(response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    }else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}