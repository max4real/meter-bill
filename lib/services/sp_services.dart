import 'package:shared_preferences/shared_preferences.dart';
import '../home/m/m_bill_model.dart';

class SpServices {
  static const String _billsKey = 'bills_data';

  /// Save a list of `BillModel` to SharedPreferences
  Future<void> saveBills(List<BillModel> bills) async {
    final prefs = await SharedPreferences.getInstance();

    // Convert List<BillModel> to List<Map<String, dynamic>> then encode as JSON
    List<String> billJsonList = bills.map((bill) => bill.toJson()).toList();

    await prefs.setStringList(_billsKey, billJsonList);
  }

  /// Get a list of `BillModel` from SharedPreferences
  Future<List<BillModel>> getBills() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? billJsonList = prefs.getStringList(_billsKey);

    if (billJsonList == null || billJsonList.isEmpty) return [];

    return billJsonList
        .map((billJson) => BillModel.fromJson(billJson))
        .toList();
  }

  /// Clear all saved bills
  Future<void> clearBills() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_billsKey);
  }
}
