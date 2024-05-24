import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_user_model.dart';
import 'package:http/http.dart' as http;

class FetchUserService{
  static var client = http.Client();

  static Future<FetchUserModel> fetchUser(int loginType,String fcmToken,String identity,String email,String country) async {
    try {

      var uri = Uri.parse(Constant.baseUrl + Constant.fetchUser);

      var payload = json.encode({
            "loginType":loginType,
            "fcm_token":fcmToken,
            "identity":identity,
            "email":email,
            "country":country,
          }.map((key, value) => MapEntry(key, value.toString())));

      final response = await http.post(uri, headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.key
        },body: payload);

      if (response.statusCode == 200) {
        return FetchUserModel.fromJson(jsonDecode(response.body));
      } else {
        log(response.statusCode.toString());
      }
      return FetchUserModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}