import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/gift/model/generate_gift_model.dart';
import 'package:http/http.dart' as http;

class GenerateGiftService {
  static var client = http.Client();

  static Future<GenerateGiftModel> generateGift(String categoryId) async {
    try {
      final queryParameters = {
        "categoryId": categoryId,
      };

      final uri =
          Uri.http(Constant.queryUrl, Constant.generateGift, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GenerateGiftModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GenerateGiftModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
