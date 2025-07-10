class FormatPassword {

  // 8 kí tự trở lên , phải có ít nhất 1 chữ hoa , 1 chữ thường , 1 số , 1 kí tự đặc biệt ( @ $ ! % * ? & )
  static bool isStrong(String password) {
    final strongRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
    );
    return strongRegex.hasMatch(password);
  }
}