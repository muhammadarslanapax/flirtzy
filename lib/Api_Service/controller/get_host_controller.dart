import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/model/get_host_model.dart';
import 'package:hokoo_flutter/Api_Service/service/get_host_service.dart';

class GetHostController extends GetxController {
  GetHostModel? getHostData;
  var isLoading = true.obs;

  Future getHost(String hostId) async {
    log("Get host Controller called");
    try {
      isLoading(true);
      getHostData = await GetHostService.getHost(hostId);
      log("Get Host: ${jsonEncode(getHostData)}");
      if (getHostData!.status == true) {
        isLoading(false);
      }
    } finally {}
  }
}
