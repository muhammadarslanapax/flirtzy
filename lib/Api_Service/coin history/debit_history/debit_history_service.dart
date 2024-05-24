import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

import 'debit_history_model.dart';

class DebitHistoryService {
  static var client = http.Client();

  static Future<DebitHistoryModel> debitHistory(
      String userId, String start, String limit,
      [String? startDate, String? endDate]) async {
    try {
      final Map<String, String?> queryParameters;

      if (startDate != null) {
        queryParameters = {
          "userId": userId,
          "start": start,
          "limit": limit,
          "startDate": startDate,
          "endDate": endDate,
        };
      } else {
        queryParameters = {
          "userId": userId,
          "start": start,
          "limit": limit,
        };
      }

      final uri =
          Uri.http(Constant.queryUrl, Constant.debitHistory, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      log("Debit data status code :- ${response.statusCode}");
      log("Debit data is :- ${response.body}");

      if (response.statusCode == 200) {
        return DebitHistoryModel.fromJson(data);
      } else {
        log(response.body);
      }
      return DebitHistoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
