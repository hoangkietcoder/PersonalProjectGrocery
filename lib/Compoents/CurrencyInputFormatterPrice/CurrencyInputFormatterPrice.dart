


import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatterPrice extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat("#,###", "vi_VN");

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
      // nếu không, con trỏ sẽ nhảy về đầu dòng, gây trải nghiệm rất tệ.
      selection: TextSelection.collapsed(offset: newFormatted.length), //
    );
  }
}