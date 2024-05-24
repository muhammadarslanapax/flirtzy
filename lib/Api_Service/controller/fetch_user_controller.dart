import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/fetch_user_model.dart';
import 'package:hokoo_flutter/Api_Service/service/fetch_user_service.dart';

class FetchUserController extends GetxController {
  FetchUserModel? userData;

  Future fetchUser(int loginType, String fcmToken, String identity,
      String email, String country) async {
    userData = await FetchUserService.fetchUser(
        loginType, fcmToken, identity, email, country);
    log("Fetch User: ${jsonEncode(userData)}");
  }
}
