


import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatterPrice extends TextInputFormatter {
  final NumberFormat formatter;

  /// Mặc định locale là "vi_VN" để hiển thị 1.000
  CurrencyInputFormatterPrice({String locale = "vi_VN"}): formatter = NumberFormat("#,###", locale);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {



    // Lấy chuỗi chỉ chứa số
    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (numericString.isEmpty) return newValue.copyWith(text: '');

    // Convert sang int và format lại
    final int number = int.parse(numericString);
    final String newFormatted = formatter.format(number);

    return TextEditingValue(
      text: newFormatted,
      // đang nhập (ví dụ: từ "1000" thành "1.000"), bạn cần cập nhật lại vị trí con trỏ (cursor) —
      // nếu không, con trỏ sẽ nhảy về đầu dòng
      selection: TextSelection.collapsed(offset: newFormatted.length), //
    );
  }
}
// việt nam sẽ có kiểu 1.000 - 100.000
String formatCurrencyVN(String value) {
  final int number = int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  return NumberFormat("#,###", "vi_VN").format(number);
}

// US sẽ có kiểu 1,000 - 100,000
String formatCurrencyUS(String value) {
  final int number = int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  return NumberFormat("#,###", "en_US").format(number);
}