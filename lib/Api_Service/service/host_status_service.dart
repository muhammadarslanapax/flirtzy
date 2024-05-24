import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/host_status_model.dart';
import 'package:http/http.dart' as http;

class HostStatusService {
  static var client = http.Client();

  static Future<HostStatusModel> checkStatus(String hostId) async {
    try {
      final queryParameters = {
        "hostId": hostId,
      };

      final uri =
          Uri.https(Constant.queryUrl, Constant.hostStatus, queryParameters);

      http.Response response =
          await client.patch(uri, headers: {"key": Constant.key});
     log(uri.toString());
     log(response.statusCode.toString());
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return HostStatusModel.fromJson(data);
      } else {
        log(response.body);
      }
      return HostStatusModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
