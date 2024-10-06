import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class PopularProductListController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage = '';

  String? get errorMassage => _errorMassage;

  List<ProductModel> _productList = [];

  bool get inProgress => _inProgress;

  List<ProductModel> get productList => _productList;

  Future<bool> getPopularProduct() async {
    bool isSuccess = false;
    
    _inProgress = true;
    update();
    
    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.productListUrl('popular'),);

    if(response.isSuccess) {
      _productList = ProductListModel.fromJson(response.responseData).productList ?? [];
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