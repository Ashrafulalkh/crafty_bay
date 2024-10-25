import 'package:crafty_bay/data/models/wish_list_data_model.dart';

class WishListModel {
  String? msg;
  List<WishListDataModel>? wishListData;

  WishListModel({this.msg, this.wishListData});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishListData = <WishListDataModel>[];
      json['data'].forEach((v) {
        wishListData!.add(WishListDataModel.fromJson(v));
      });
    }
  }

}

