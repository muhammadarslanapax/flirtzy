import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/story/model/host_vise_story_model.dart';
import 'package:http/http.dart' as http;

class HostViceStoryService {

  static var client = http.Client();

  static Future<HostViseStoryModel> hostViceStory(String hostId) async {
    try {
      final queryParameters = {
        "hostId": hostId,
      };

      final uri =
      Uri.http(Constant.queryUrl, Constant.hostViceAllStory, queryParameters);

      http.Response response =
      await client.get(uri, headers: {"key": Constant.key});
      log(response.statusCode.toString());
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return HostViseStoryModel.fromJson(data);
      } else {
        log(response.body);
      }
      return HostViseStoryModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
