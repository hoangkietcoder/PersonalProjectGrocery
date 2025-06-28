import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// trạng thái đăng nhập ( lưu trạng thái đăng nhập ) có bảo mật ) như pass , token ,

class SecureStorageRepository {
  /// {@macro secure_storage_repository}
  final _secureStorage = const FlutterSecureStorage();
  // static String? accountName;
  IOSOptions _getIOSOptions(String? accountName) => IOSOptions(
    accountName: getAccountName(accountName), // dùng cho IOS
  );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true, // dùng cho Android
  );

  String? getAccountName(String? accountName) =>
      accountName; // như keychain , key mình là gì là lấy key đó

  // set data
  Future<void> setString(
      String valueString, String keyString, String? accountName) async {
    await _secureStorage.write(
        key: keyString,
        value: valueString,
        iOptions: _getIOSOptions(accountName),
        aOptions: _getAndroidOptions());
  }

  // lấy data
  Future<String?> getString(String keyString, String? accountName) async =>
      await _secureStorage.read(
          key: keyString,
          iOptions: _getIOSOptions(accountName),
          aOptions: _getAndroidOptions());

  // static Future setString(String data, String key) async => await _secureStorage.write(
  //     key:key,
  //     value: data,
  //     iOptions: _getIOSOptions(accountName),
  //     aOptions: _getAndroidOptions()
  // );
  //
  // static  Future<String?> getString(String key) async => await _secureStorage.read(
  //     key:key,
  //     iOptions: _getIOSOptions(accountName),
  //     aOptions: _getAndroidOptions()
  // );

  Future<void> removeSecure(String key, String? accountName) async {
    await _secureStorage.delete(
        key: key,
        iOptions: _getIOSOptions(accountName),
        aOptions: _getAndroidOptions());
  }

  Future<void> removeAll(String? accountName) async {
    _secureStorage.deleteAll(
        iOptions: _getIOSOptions(accountName), aOptions: _getAndroidOptions());
  }
}
