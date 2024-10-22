class CustomerProfileModel {
  int? id;
  String? cusName;

  CustomerProfileModel({this.id, this.cusName});

  CustomerProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }

}