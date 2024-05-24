import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/chat/model/chat_thumb_model.dart';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:http/http.dart' as http;

class ChatThumbService {
  static var client = http.Client();

  static Future<ChatThumbModel> getChatThumb(String id, String type) async {
    try {
      final queryParameters = {
        "type": type,
        "userId": id,
      };

      final uri =
          Uri.http(Constant.queryUrl, Constant.chatThumbList, queryParameters);

      http.Response response =
          await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ChatThumbModel.fromJson(data);
      } else {
        log(response.body);
      }
      return ChatThumbModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
