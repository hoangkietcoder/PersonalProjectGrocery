import 'package:shared_preferences/shared_preferences.dart';

/// {@template shared_preferences_repository}
/// A repository that handles shared preferences related requests
/// {@endtemplate}
///
///
///
///
// lưu trữ dữ liệu ko cần bảo mật nhiều
class SharedPreferencesRepository {
  /// {@macro shared_preferences_repository}

  SharedPreferences? _prefs;

  Future<void> init() async => _prefs = await SharedPreferences.getInstance(); // hàm khởi tạo

  Future<bool?> setList(String key,List<String> value, ) async => await _prefs?.setStringList(key, value);

  List<String>? getList(String key) => _prefs?.getStringList(key);

  Future<void> setBool(String key,bool value) async => await _prefs?.setBool(key, value);

  bool? getBool(String key) => _prefs?.getBool(key);

  Future<void> setString(String key,String value) async => await  _prefs?.setString(key, value);

  String? getString(String key) =>  _prefs?.getString(key);

  Future<void> setInt(String key,int value) async => await  _prefs?.setInt(key, value);

  int? getInt(String key) =>  _prefs?.getInt(key);

  Future<void> removeShared(String key) async => await _prefs?.remove(key);

}
