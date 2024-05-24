import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/get_user_model.dart';
import 'package:http/http.dart' as http;

class GetUserService {
  static var client = http.Client();

 static Future<GetUserModel> getUser(String userId) async {
    try {
      final queryParameters = {
        "id": userId,
      };

      final uri =
          Uri.http(Constant.queryUrl, Constant.getUser, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetUserModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetUserModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
