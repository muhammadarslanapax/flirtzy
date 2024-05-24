import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/model/get_coin_plan_model.dart';
import 'package:http/http.dart' as http;

class GetCoinPlanService {
  static var client = http.Client();

  static Future<GetCoinPlanModel> getCoinPlan() async {
    try {
      var uri = Uri.parse(Constant.baseUrl + Constant.coinPlan);
      final response = await client.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.key
        },
      );
      var data = jsonDecode(response.body);

      if (kDebugMode) {
        print(response.statusCode);
        print(response.body);
      }

      if (response.statusCode == 200) {
        return GetCoinPlanModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetCoinPlanModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
