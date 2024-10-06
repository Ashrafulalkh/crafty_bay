import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/data/models/product_list_model.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage = '';

  String? get errorMassage => _errorMassage;

  ProductDetailsModel? _productModel;

  bool get inProgress => _inProgress;

  ProductDetailsModel? get productModel => _productModel;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    
    _inProgress = true;
    update();
    
    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.productDetailsUrl(productId),);

    if(response.isSuccess) {
      _productModel = ProductDetailsModel.fromJson(response.responseData['data'][0]);
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