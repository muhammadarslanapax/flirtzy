import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/host_thumb_list_model.dart';
import 'package:http/http.dart' as http;

class HostThumbService{
  static var client = http.Client();

  static Future<HostThumbListModel> hostThumbList(String country) async {
    try {
      final queryParameters = {
        "countryName": country,
      };

      final uri =
      Uri.http(Constant.queryUrl, Constant.fetchHostThumbList, queryParameters);

      http.Response response =
      await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      log("Response body is :: ${response.body}");

      if (response.statusCode == 200) {
        return HostThumbListModel.fromJson(data);
      } else {
        log(response.body);
      }
      return HostThumbListModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
  // static Future<HostThumbListModel> hostThumbList() async {
  //   try {
  //     var uri = Uri.parse(Constant.baseUrl + Constant.fetchHostThumbList);
  //
  //     final response = await client.get(uri, headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       "key": Constant.key
  //     });
  //
  //     var data = jsonDecode(response.body);
  //     if (response.statusCode == 200) {
  //       return HostThumbListModel.fromJson(data);
  //     } else {
  //       log(response.statusCode.toString());
  //     }
  //     return HostThumbListModel.fromJson(data);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
}