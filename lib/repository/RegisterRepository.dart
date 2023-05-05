
import 'dart:convert';

import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/models/AuthUser.dart';
import 'package:UdemyClone/models/RegisterPayload.dart';
import 'package:http/http.dart' as http;
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
class RegisterRepository {
  String userUrl = ApiConst.REGISTER_ENDPOINT;

  Future<bool> register(RegisterPayload payload) async {
    Map<String, String> formData = {
      'username': payload.username,
      'password': payload.password,
      'fullname' : payload.fullname,
      'birthdate' : payload.birthdate,
      'gender' : payload.gender,
      'email' : payload.email,
      'phone' : payload.phone
    };
    // String encodedFormData = formData.keys.map((key) => '$key=${formData[key]}').join('&');
    // Response response = await post(
    //     Uri.parse(userUrl),
    //     body: encodedFormData,
    //     headers: {"Accept": "application/json;charset=utf-8", "Content-Type": "application/json"},
    // );
    //
    // if (response.statusCode == 200) {
    //   print("register successful");
    //   return true;
    // } else {
    //   print("from repository: " + response.reasonPhrase);
    //   return false;
    // }
    var request = http.MultipartRequest('POST', Uri.parse(userUrl));

// Add the form fields to the request
    request.fields.addAll(formData);

// Get the content type of the multipart request
    var contentType = request.headers['content-type'];

// Send the POST request with the form data
    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      // Success
      print('Data submitted successfully!');
      return true;
    } else {
      // Error
      print('Error submitting data: ${response.statusCode}');
      return false;
    }
  }
}