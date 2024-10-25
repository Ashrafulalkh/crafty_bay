import 'package:crafty_bay/data/models/cart_list_data_model.dart';
import 'package:crafty_bay/data/models/product_model.dart';

class CartListModel {
  String? msg;
  List<CartListDataModel>? cartListData;

  CartListModel({this.msg, this.cartListData});

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      cartListData = <CartListDataModel>[];
      json['data'].forEach((v) {
        cartListData!.add(CartListDataModel.fromJson(v));
      });
    }
  }

}




