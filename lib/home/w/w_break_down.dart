import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meter_bill/const/dark_theme.dart';
import 'package:meter_bill/home/m/m_breakdown_model.dart';

class BreakDownWidget extends StatelessWidget {
  final DateTime currentDate;
  final int previousUnit_;
  final int currentUnit_;
  final int totalUnit;
  final int totalAmount;
  final List<BreakdownItem> breakdownList;
  final Function onSave;

  const BreakDownWidget({
    super.key,
    required this.currentDate,
    required this.previousUnit_,
    required this.currentUnit_,
    required this.totalUnit,
    required this.breakdownList,
    required this.totalAmount,
    required this.onSave(),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat("MMMM / yyyy").format(currentDate),
                style: TextStyle(
                  color: primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(),
              Text(
                'ယခင်လဖတ်ချက် - ',
                style: TextStyle(
                  color: primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                previousUnit_.toString(),
                style: TextStyle(
                  color: secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'ယခုလဖတ်ချက် - ',
                style: TextStyle(
                  color: primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                currentUnit_.toString(),
                style: TextStyle(
                  color: secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'ကွာခြားယူနစ် - ',
                style: TextStyle(
                  color: primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                totalUnit.toString(),
                style: TextStyle(
                  color: secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Divider(),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    onSave();
                  },
                  child: Icon(
                    Icons.save_alt_outlined,
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: primary,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Column(
                    spacing: 0,
                    children: breakdownList.map((item) {
                      return ListTile(
                        dense: true,
                        title: Text(
                          "${item.rate} x ${item.units}",
                          style: TextStyle(color: primary),
                        ),
                        trailing: Text(
                          "= ${item.amount}",
                          style: TextStyle(
                            color: secondary,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Divider(height: 0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      "Total: ${totalUnit}",
                      style: TextStyle(color: primary),
                    ),
                    trailing: Text(
                      "= $totalAmount Ks",
                      style: TextStyle(
                        color: secondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
