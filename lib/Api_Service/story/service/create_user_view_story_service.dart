import 'dart:convert';
import 'dart:developer';
import 'package:hokoo_flutter/Api_Service/constant.dart';
import 'package:hokoo_flutter/Api_Service/story/model/create_user_view_story_model.dart';
import 'package:http/http.dart' as http;

class  CreateUserViewStoryService {

  static var client = http.Client();

  static Future<CreateUserViewStoryModel> createUserViewStory (String userId, String storyId) async {
    try {
      final queryParameters = {
        "userId": userId,
        "storyId" : storyId,
      };

      final uri = Uri.https(Constant.queryUrl, Constant.createUserViewStory, queryParameters);

      final response = await client.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "key": Constant.key
          },);

      var body = json.decode(response.body);

      log("Create User View Story Response :- ${response.statusCode}");
      log("Create User View Data :- ${response.body}");



      if (response.statusCode == 200) {
        return CreateUserViewStoryModel.fromJson(body);
      } else {
        log(response.body);
      }
      return CreateUserViewStoryModel.fromJson(body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
