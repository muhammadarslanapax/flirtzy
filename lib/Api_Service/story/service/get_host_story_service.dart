import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/story/model/get_host_story_model.dart';
import 'package:http/http.dart' as http;

class GetHostStoryService {
  static var client = http.Client();

  static Future<GetHostStoryModel> getHostStory(
    String userId,
  ) async {
    try {
      final queryParameters = {
        "userId": userId,
      };

      final uri = Uri.http(Constant.queryUrl, Constant.getHostStory, queryParameters);

      http.Response response = await client.get(uri, headers: {"key": Constant.key});

      var data = jsonDecode(response.body);

      log("Get Host Story Response :- ${response.statusCode}");
      log("Get Host Story Data :- ${response.body}");

      if (response.statusCode == 200) {
        return GetHostStoryModel.fromJson(data);
      } else {
        log(response.body);
      }
      return GetHostStoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
