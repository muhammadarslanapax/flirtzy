import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/models/get_withdraw_type_model.dart';
import 'package:hokoo_flutter/Api_Service/withdraw/service/withdraw_type_service.dart';

class WithdrawTypeController extends GetxController {

  GetWithdrawTypeModel? getWithdrawTypeModel;
  var isLoading = true.obs;

  Future withdrawType() async {
    try {
      isLoading(true);
      getWithdrawTypeModel = await WithdrawTypeService.getWithdrawTypeService();
      log("Withdraw Type Data:- ${jsonEncode(getWithdrawTypeModel)}");
      if (getWithdrawTypeModel!.status == true) {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}

