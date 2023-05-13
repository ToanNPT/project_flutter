
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
    var request = http.MultipartRequest('POST', Uri.parse(userUrl));

// Add the form fields to the request
    request.fields.addAll(formData);

// Get the content type of the multipart request
    var contentType = request.headers['content-type'];

// Send the POST request with the form data
    http.Response response = await http.Response.fromStream(await request.send());

    var a = jsonDecode(response.body);
    if (a["errorCode"] == "") {
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