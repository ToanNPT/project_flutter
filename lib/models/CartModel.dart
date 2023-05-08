import 'package:UdemyClone/models/Course.dart';

class CartModel {
  final String username;
  final num totalPrice;
  final num paymentPrice;
  final List<Course> cartDetailList;

  CartModel({this.username, this.totalPrice, this.paymentPrice, this.cartDetailList});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return  CartModel(
        username: json["username"],
        totalPrice: json["totalPrice"],
        paymentPrice: json["paymentPrice"],
        cartDetailList:  (json['cartDetailList'] as List<dynamic>).map((c) => Course.fromJson(c)).toList());
  }
}