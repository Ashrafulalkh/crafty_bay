import 'package:crafty_bay/data/models/cart_list_data_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/wish_list_data_model.dart';
import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;

  String? _errorMassage;

  List<WishListDataModel> _wishListData = [];

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  List<WishListDataModel> get wishListData => _wishListData;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response =
    await Get.find<NetworkCaller>().getRequest(url: Urls.wishListUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMassage = null;
      _wishListData = WishListModel.fromJson(response.responseData).wishListData ?? [];
    } else {
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
