import 'package:crafty_bay/data/models/cart_list_data_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;

  String? _errorMassage;

  List<CartListDataModel> _cartListData = [];

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  List<CartListDataModel> get cartListData => _cartListData;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: Urls.cartListUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMassage = null;
      _cartListData = CartListModel.fromJson(response.responseData).cartListData ?? [];
    } else {
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
