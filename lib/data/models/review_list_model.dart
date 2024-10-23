import 'package:crafty_bay/data/models/review_list_data_model.dart';

class ReviewListModel {
  String? msg;
  List<ReviewListDataModel>? reviewListData;

  ReviewListModel({this.msg, this.reviewListData});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewListData = <ReviewListDataModel>[];
      json['data'].forEach((v) {
        reviewListData!.add(ReviewListDataModel.fromJson(v));
      });
    }
  }
}

