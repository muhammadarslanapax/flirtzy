import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;
import 'recharge_history_model.dart';

class RechargeHistoryService {
  static var client = http.Client();

  static Future<RechargeHistoryModel> rechargeHistory(
      String userId, String type,
      [String? startDate, String? endDate]) async {
    try {
      final Map<String, String?> queryParameters;
      if (startDate != null) {
        queryParameters = {
          "userId": userId,
          "type": type,
          "startDate": startDate,
          "endDate": endDate,
        };
      } else {
        queryParameters = {
          "userId": userId,
          "type": type,
        };
      }

      final uri = Uri.http(
          Constant.queryUrl, Constant.rechargeHistory, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return RechargeHistoryModel.fromJson(data);
      } else {
        log(response.body);
      }
      return RechargeHistoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
