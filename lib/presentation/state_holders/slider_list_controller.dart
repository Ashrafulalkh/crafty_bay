import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/slider_list_model.dart';
import 'package:crafty_bay/data/models/slider_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;

  String? _errorMassage;

  List<SliderModel> _sliderList = [];

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  List<SliderModel> get sliderList => _sliderList;

  Future<bool> getSliderList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(url: Urls.sliderListUrl);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMassage = null;
      _sliderList = SliderListModel.fromJson(response.responseData).sliderList ?? [];
    } else {
      _errorMassage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
