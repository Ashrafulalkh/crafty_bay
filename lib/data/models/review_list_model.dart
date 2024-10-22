import 'package:crafty_bay/data/models/review_list_data_model.dart';

class ReviewListModel {
  String? msg;
  List<ReviewListDataModel>? data;

  ReviewListModel({this.msg, this.data});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ReviewListDataModel>[];
      json['data'].forEach((v) {
        data!.add(ReviewListDataModel.fromJson(v));
      });
    }
  }
}

