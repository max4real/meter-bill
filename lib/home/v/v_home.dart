import 'package:flutter/material.dart';
import 'package:meter_bill/bill_detail/v_bill_detail.dart';
import 'package:meter_bill/const/dark_theme.dart';
import 'package:meter_bill/home/c/c_home.dart';
import 'package:get/get.dart';
import 'package:meter_bill/home/w/w_break_down.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: false,
        title: Text(
          'Meter Bill',
          style: TextStyle(
            color: primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const BillDetailPage())!.then(
                (value) {
                  controller.initLoad();
                },
              );
            },
            icon: Icon(
              Icons.history_outlined,
              color: secondary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            children: [
              TextField(
                controller: controller.txtpreviousUnit,
                keyboardType: TextInputType.number,
                maxLines: 1,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                cursorWidth: 1,
                cursorColor: background,
                cursorHeight: 18,
                style: TextStyle(
                    color: background,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: primary,
                  hintText: "ယခင်လဖတ်ချက်", //ယခု
                ),
              ),
              TextField(
                controller: controller.txtcurrentUnit,
                keyboardType: TextInputType.number,
                maxLines: 1,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                cursorWidth: 1,
                cursorColor: background,
                cursorHeight: 18,
                style: TextStyle(
                    color: background,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: primary,
                  hintText: "ယခုလဖတ်ချက်",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.checkAllField();
                },
                child: Text(
                  'တွက်မည်',
                  style: TextStyle(
                    color: background,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(color: secondary),
              ValueListenableBuilder(
                valueListenable: controller.breakdownList,
                builder: (context, breakDownList, child) {
                  if (breakDownList.isEmpty) {
                    return Text(
                      '-',
                      style: TextStyle(
                        color: secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return BreakDownWidget(
                      currentDate: controller.currentDate,
                      previousUnit_: controller.previousUnit_,
                      currentUnit_: controller.currentUnit_,
                      totalUnit: controller.totalUnit,
                      breakdownList: breakDownList,
                      totalAmount: controller.totalAmount,
                      onSave: () {
                        controller.saveResult();
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
