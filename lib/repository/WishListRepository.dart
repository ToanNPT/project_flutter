import 'dart:convert';

import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/models/PagingData.dart';
import 'package:UdemyClone/models/WishListModel.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:http/http.dart';
import 'package:supercharged/supercharged.dart';
import 'package:UdemyClone/ultis/constants.dart' as Constants;
class WishListRepository {
  StorageRepository storageRepository;

  WishListRepository(){
    this.storageRepository = new StorageRepository();
  }

  Future<List<WishListModel>> fetchData() async {
    String token = await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    if(token.isEmpty)
      throw Exception("must login");

    Response response = await get(
        Uri.parse(ApiConst.WISHLIST),
        headers: {"Accept": "application/json;charset=utf-8",  "Authorization": "Bearer " + token}
    );

    if (response.statusCode == 200) {
      bool isLastPage = jsonDecode(response.body)["data"]["last"] == "true" ? true : false;
      final List<dynamic> jsonList = jsonDecode(response.body)["data"]["content"];
      final wishListData =  jsonList.map((data) => WishListModel.fromJson(data)).toList();
      return wishListData;
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> deleteItem(String id) async {
    String token = await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    if(token.isEmpty)
      throw Exception("must login");

    Response response = await delete(
        Uri.parse(ApiConst.WISHLIST +"/" + id.toString()),
        headers: {"Accept": "application/json;charset=utf-8",  "Authorization": "Bearer " + token}
    );

    if (response.statusCode == 200) {
      var code = jsonDecode(response.body)["errorCode"];
      return code == "" ? true : false;
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> addItem(String id) async {
    String token = await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    if(token.isEmpty)
      throw Exception("must login");

    Response response = await post(
        Uri.parse(ApiConst.WISHLIST +"/" + id.toString()),
        headers: {"Accept": "application/json;charset=utf-8",  "Authorization": "Bearer " + token}
    );

    if (response.statusCode == 200) {
      var code = jsonDecode(response.body)["errorCode"];
      return code == "" ? true : false;
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

}
