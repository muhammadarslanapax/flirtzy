import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/Complain/host_complain/get_host_complain/get_host_complain_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

class GetHostComplainService {
  static var client = http.Client();

  static Future<GetHostComplainModel> getHostComplain(String hostId) async {
    try {
      final queryParameters = {
        "hostId": hostId,
      };

      final uri = Uri.http(
          Constant.queryUrl, Constant.getHostComplain, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetHostComplainModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetHostComplainModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
