import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_bill/const/dark_theme.dart';

void showCustomDialog(
    {required String message, bool xSuccess = false, required Color color}) {
  Get.dialog(
    Dialog(
      backgroundColor: const Color(0XFF262D39),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: xSuccess
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    )
                  : const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

void showCustomDialog2(
  String message,
  Function ok,
  String okButton,
) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: background,
                    minimumSize: const Size(120, 35),
                  ),
                  child: Text(
                    "Cancle",
                    style: TextStyle(color: text1, fontSize: 14),
                  ),
                ),
                SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    ok();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: background,
                    minimumSize: const Size(120, 35),
                  ),
                  child: Text(
                    okButton,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
