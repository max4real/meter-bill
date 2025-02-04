import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_bill/const/widgets/w_custom_dialog.dart';
import 'package:meter_bill/home/m/m_breakdown_model.dart';

import '../../services/sp_services.dart';
import '../m/m_bill_model.dart';

class HomeController extends GetxController {
  TextEditingController txtpreviousUnit = TextEditingController();
  TextEditingController txtcurrentUnit = TextEditingController();

  ValueNotifier<List<BreakdownItem>> breakdownList = ValueNotifier([]);
  int totalUnit = 0;
  int totalAmount = 0;
  int previousUnit_ = 0;
  int currentUnit_ = 0;
  DateTime currentDate = DateTime.now();

  final List<int> unitThresholds = [
    30,
    20,
    25,
    25,
    50,
    50,
  ]; // Unit breakpoints
  final List<int> rates = [
    35,
    50,
    70,
    90,
    110,
    120,
    125
  ]; // Corresponding rates

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() async {
    final spServices = SpServices();

    final savedBills = await spServices.getBills();
    if (savedBills.isNotEmpty) {
      txtpreviousUnit.text = savedBills.last.currentUnit.toString();
    } else {
      txtpreviousUnit.text = "0";
    }
  }

  void checkAllField() {
    int previousUnit;
    int currentUnit;
    try {
      if (txtcurrentUnit.text.isEmpty || txtpreviousUnit.text.isEmpty) {
        showCustomDialog(
          message: "ကျေးဇူးပြု၍ နံပါတ်အားလုံးကို ထည့်ပါ။",
          color: Colors.red,
        );
        return;
      }
      previousUnit = int.parse(txtpreviousUnit.text);
      currentUnit = int.parse(txtcurrentUnit.text);

      previousUnit_ = previousUnit;
      currentUnit_ = currentUnit;

      breakDown(previousUnit: previousUnit, currentUnit: currentUnit);
    } catch (e) {
      showCustomDialog(
          message: "ကျေးဇူးပြု၍ နံပါတ်ကို \nမှန်ကန်စွာ ထည့်ပါ။",
          color: Colors.red);
    }
  }

  void breakDown({required int previousUnit, required int currentUnit}) {
    totalUnit = currentUnit - previousUnit;
    int remainingUnits = totalUnit;
    int index = 0;
    breakdownList.value.clear();
    List<BreakdownItem> temp = [];
    int total = 0;

    for (int threshold in unitThresholds) {
      if (remainingUnits > 0) {
        int currentUnits =
            (remainingUnits >= threshold) ? threshold : remainingUnits;

        total += currentUnits * rates[index];

        temp.add(
          BreakdownItem(
              units: currentUnits,
              rate: rates[index],
              amount: currentUnits * rates[index]),
        );
        remainingUnits -= currentUnits;
        index++;
      } else {
        break;
      }
    }

    // If there are any remaining units, apply the last rate
    if (remainingUnits > 0) {
      total += remainingUnits * rates[index];
      temp.add(
        BreakdownItem(
            units: remainingUnits,
            rate: rates[index],
            amount: remainingUnits * rates[index]),
      );
    }
    totalAmount = total;
    breakdownList.value = temp;
  }

  void saveResult() async {
    final spServices = SpServices();
    List<BillModel> allBills = await spServices.getBills();
    final latestBill = BillModel(
      previousUnit: previousUnit_,
      currentUnit: currentUnit_,
      usedUnit: totalUnit,
      totalAmount: totalAmount,
      billMonth: currentDate,
    );
    allBills.add(latestBill);

    await spServices.saveBills(allBills);

    showCustomDialog(
      message: "ဘေလ်ကို အောင်မြင်စွာ သိမ်းဆည်းပြီးပါပြီ။",
      color: Colors.green,
      xSuccess: true,
    );
    breakdownList.value = [];
    txtpreviousUnit.text = txtcurrentUnit.text;
    txtcurrentUnit.clear();
  }

  void getall() async {
    final spServices = SpServices();

    final savedBills = await spServices.getBills();
    if (savedBills.isNotEmpty) {
      for (var bill in savedBills) {
        print("Previous Unit: ${bill.previousUnit}");
        print("Current Unit: ${bill.currentUnit}");
        print("Used Unit: ${bill.usedUnit}");
        print("Total Amount: ${bill.totalAmount}");
        print("Bill Month: ${bill.billMonth}");
        print("------------------");
      }
    } else {
      print("No bill data found.");
    }
  }
}
