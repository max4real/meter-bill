import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../const/dark_theme.dart';
import 'c_bill_detail.dart';

class BillDetailPage extends StatelessWidget {
  const BillDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    BillDetailController controller = Get.put(BillDetailController());
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          'ဘေစာရင်း',
          style: TextStyle(
            color: primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.deleteAll();
            },
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ValueListenableBuilder(
          valueListenable: controller.billList,
          builder: (context, billList, child) {
            if (billList.isEmpty) {
              return Center(
                child: Text(
                  'ဘေလ်စာရင်းမရှိပါ။',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: billList.length,
                itemBuilder: (context, index) {
                  final each = billList[index];
                  final eachDate = each.billMonth;
                  return Card(
                    child: ListTile(
                      title: Text(
                        DateFormat("MMMM / yyyy").format(each.billMonth),
                        style: TextStyle(
                          color: background,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "ယခင်လဖတ်ချက် - ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${DateFormat("dd/MM/yyyy").format(
                                  DateTime(eachDate.year, eachDate.month - 1,
                                      eachDate.day),
                                )} - ${each.previousUnit}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "ယခုလဖတ်ချက် - ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${DateFormat("dd/MM/yyyy").format(eachDate)} - ${each.currentUnit}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "စုစုပေါင်းယူနစ် - ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${each.usedUnit}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "စုစုပေါင်းတန်ဘိုး - ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${each.totalAmount} Ks",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
