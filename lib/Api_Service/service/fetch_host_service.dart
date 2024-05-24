import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_host_model.dart';
import 'package:http/http.dart' as http;

class FetchHostService {
  static var client = http.Client();

  static Future<FetchHostModel> fetchHost(
      int loginType, String fcmToken, String identity, String email,String country) async {
    try {
      var uri = Uri.parse(Constant.baseUrl + Constant.fetchHost);
      var payload = json.encode({
        "loginType": loginType,
        "fcm_token": fcmToken,
        "identity": identity,
        "email": email,
        "country": country,
      }.map((key, value) => MapEntry(key, value.toString())));

      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "key": Constant.key
          },
          body: payload);

      if (response.statusCode == 200) {
        return FetchHostModel.fromJson(jsonDecode(response.body.toString()));
      } else {
        log(response.statusCode.toString());
      }
      return FetchHostModel.fromJson(jsonDecode(response.body.toString()));
    } catch (e) {
      throw Exception(e);
    }
  }
}
