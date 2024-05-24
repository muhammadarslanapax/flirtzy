import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/sticker/sticker_model.dart';
import 'package:http/http.dart' as http;

class StickerService {

  static var client = http.Client();

  static Future<StickerModel> sticker () async {
    try {
      var uri = Uri.parse(Constant.baseUrl + Constant.sticker);

      final response = await client.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.key
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return StickerModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }
      return StickerModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }

  }

}
