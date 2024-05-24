import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/get_host_model.dart';
import 'package:http/http.dart' as http;

class GetHostService {
  static var client = http.Client();

  static Future<GetHostModel> getHost(String hostId) async {
    try {
      final queryParameters = {
        "hostId": hostId,
      };

      final uri =
      Uri.http(Constant.queryUrl, Constant.getHost, queryParameters);

      http.Response response =
      await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetHostModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetHostModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
