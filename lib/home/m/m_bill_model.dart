// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BillModel {
  int previousUnit;
  int currentUnit;
  int usedUnit;
  int totalAmount;
  DateTime billMonth;

  BillModel({
    required this.previousUnit,
    required this.currentUnit,
    required this.usedUnit,
    required this.totalAmount,
    required this.billMonth,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'previousUnit': previousUnit,
      'currentUnit': currentUnit,
      'usedUnit': usedUnit,
      'totalAmount': totalAmount,
      'billMonth': billMonth.millisecondsSinceEpoch,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      previousUnit: map['previousUnit'] as int,
      currentUnit: map['currentUnit'] as int,
      usedUnit: map['usedUnit'] as int,
      totalAmount: map['totalAmount'] as int,
      billMonth: DateTime.fromMillisecondsSinceEpoch(map['billMonth'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory BillModel.fromJson(String source) =>
      BillModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
