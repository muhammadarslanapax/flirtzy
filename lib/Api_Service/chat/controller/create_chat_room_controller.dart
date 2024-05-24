import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/chat/model/create_chat_room_model.dart';
import 'package:hokoo_flutter/Api_Service/chat/service/create_chat_room_service.dart';

class CreateChatRoomController extends GetxController {
  CreateChatRoomModel? createChatRoomData;
  var isLoading = true.obs;

  Future createChatRoom(String userId, String hostId) async {
    try {
      isLoading(true);
      createChatRoomData =
          await CreateChatRoomService.createChatRoom(userId, hostId);
      log("Chat Room Data: ${jsonEncode(createChatRoomData)}");
      if (createChatRoomData!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
