import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;
import 'global_country_model.dart';

class GlobalCountryService {
  static var client = http.Client();

  static Future<GlobalCountryModel> globalCountry() async {
    try {
      var uri = Uri.parse(Constant.baseUrl + Constant.globalCountry);

      final response = await client.get(uri, headers: {"key": Constant.key});
      if (response.statusCode == 200) {
        return GlobalCountryModel.fromJson(jsonDecode(response.body));
      } else {
        log(response.statusCode.toString());
      }
      return GlobalCountryModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e);
    }
  }
}
