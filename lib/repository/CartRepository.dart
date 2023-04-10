import 'dart:convert';

import 'package:UdemyClone/models/CartModel.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:UdemyClone/ultis/constants.dart' as Constants;
import 'package:http/http.dart';

class CartRepository {
  StorageRepository storageRepository;

  CartRepository() {
    this.storageRepository = new StorageRepository();
  }

  Future<CartModel> fetchData() async {
    String token =
        await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    if (token.isEmpty) throw Exception("must login");

    Response response = await get(Uri.parse(ApiConst.CART), headers: {
      "Accept": "application/json;charset=utf-8",
      "Authorization": "Bearer " + token
    });

    if (response.statusCode == 200) {
      final dataFromJson = jsonDecode(response.body)["data"];
      var model = CartModel.fromJson(dataFromJson);
      return model;
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> deleteItem(String id) async {
    String token =
        await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    if (token.isEmpty) throw Exception("must login");

    Response response = await delete(
        Uri.parse(ApiConst.CART + "/" + id.toString()),
        headers: {
          "Accept": "application/json;charset=utf-8",
          "Authorization": "Bearer " + token
        });

    if (response.statusCode == 200) {
      var code = jsonDecode(response.body)["errorCode"];
      return code == "" ? true : false;
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<bool> addItem(String id) async {
    String token =
        await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    if (token.isEmpty) throw Exception("must login");

    Response response = await post(
        Uri.parse(ApiConst.CART + "/" + id.toString()),
        headers: {
          "Accept": "application/json;charset=utf-8",
          "Authorization": "Bearer " + token
        });

    if (response.statusCode == 200) {
      var code = jsonDecode(response.body)["errorCode"];
      return code == "" ? true : false;
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }
}
