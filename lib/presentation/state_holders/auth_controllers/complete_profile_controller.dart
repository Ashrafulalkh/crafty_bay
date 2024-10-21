import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress= false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> completeProfile(String cusName,String cusAddress,String cusFax,String cusNumber,String cusCity,String cusState,
      String cusPostCode,String cusCountry,String shipName,String shipPhone,String shipCity,String shipPostCode,
      String shipCountry,String shipAddress,String shipSatate) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String,dynamic> requesBody = {
      "cus_name": cusName,
      "cus_add": cusAddress,
      "cus_city": cusCity,
      "cus_state": cusState,
      "cus_postcode": cusPostCode,
      "cus_country": cusCountry,
      "cus_phone": cusNumber,
      "cus_fax": cusFax,
      "ship_name": shipName,
      "ship_add": shipAddress,
      "ship_city": shipCity,
      "ship_state": shipSatate,
      "ship_postcode": shipPostCode,
      "ship_country": shipCountry,
      "ship_phone": shipPhone
    };

    NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: Urls.completeProfileUrl,body: requesBody);
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