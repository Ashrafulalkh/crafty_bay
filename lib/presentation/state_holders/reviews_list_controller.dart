import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/review_list_data_model.dart';
import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewsListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage = '';
  List<ReviewListDataModel> _reviewList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<ReviewListDataModel> get reviewList => _reviewList;

  Future<bool> getReviews(int id) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.reviewUrl(id));
    if(response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _reviewList = ReviewListModel.fromJson(response.responseData).reviewListData ?? [];
    }else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;

  }

}