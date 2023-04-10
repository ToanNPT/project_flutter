import 'package:UdemyClone/models/Course.dart';

class WishListModel {
  final num id;
  final String username;
  final Course courseInfo;

  WishListModel({this.id, this.username, this.courseInfo});

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    return WishListModel(
        id: json["id"], username: json["username"], courseInfo: Course.fromJson(json["courseInfo"]));
  }

}