import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_bill/const/widgets/w_custom_dialog.dart';
import 'package:meter_bill/home/m/m_bill_model.dart';

import '../services/sp_services.dart';

class BillDetailController extends GetxController {
  ValueNotifier<List<BillModel>> billList = ValueNotifier([]);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() async {
    final spServices = SpServices();

    final savedBills = await spServices.getBills();
    billList.value = savedBills;
  }

  void deleteAll() async {
    showCustomDialog2("ဖျက်ချင်တာ သေချာသလား?", () async {
      final spServices = SpServices();
      await spServices.clearBills();
      Get.back();
      initLoad();
    }, "Delete");
  }
}
