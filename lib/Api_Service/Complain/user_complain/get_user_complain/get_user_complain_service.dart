import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/Complain/user_complain/get_user_complain/get_user_complain_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

class GetUserComplainService {
  static var client = http.Client();

  static Future<GetUserComplainModel> getUserComplain(String userId) async {
    try {
      final queryParameters = {
        "userId": userId,
      };

      final uri = Uri.http(
          Constant.queryUrl, Constant.getUserComplain, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetUserComplainModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetUserComplainModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
