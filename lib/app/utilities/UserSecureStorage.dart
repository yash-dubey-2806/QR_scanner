
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage =   FlutterSecureStorage();

  static const _keyUsername = 'username';
  static const _keyToken = 'token';
  static const _keyLatitude = 'latitude';
  static const _keyLongitude = 'longitude';
  static const _keyEmailId = "email";
  static const _keyUserId = "userId";
  static const _keyRole = "role";
  static const _keyLoginTime = "LoginTime";

  static Future setUsername(String username) async =>
      await _storage.write(key: _keyUsername, value: username);

  static Future<String> getUsername() async {
    var userName;
    await _storage.read(key: _keyUsername).then((value) => userName = value);
    return userName;
  }
  static Future setEmail(String email) async =>
      await _storage.write(key: _keyEmailId, value: email);

  static Future<String> getEmail() async {
    var userName;
    await _storage.read(key: _keyUsername).then((value) => userName = value);
    return userName;
  }
  static Future setRole(String role) async =>
      await _storage.write(key: _keyRole, value: role);

  static Future<String> getRole() async {
    var userName;
    await _storage.read(key: _keyUsername).then((value) => userName = value);
    return userName;
  }


  static Future setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> getToken() async {
    var token;
    await _storage.read(key: _keyToken).then((value) => token = value);
    return token;
  }
  static Future setLoginTime(time) async {
    await _storage.write(key: _keyLoginTime, value: time);
  }

  static Future<String?> getLoginTime() async {
    var time;
    await _storage.read(key: _keyLoginTime).then((value) => time = value);
    return time;
  }


  static Future setLatitude(double latitude) async =>
      await _storage.write(key: _keyLatitude, value: latitude.toString());

  static Future<String?> getLatitude() async {
    var latitude;
    await _storage.read(key: _keyLatitude).then((value) => latitude = value);
    return latitude;
  }

  static Future setLongitude(double longitude) async =>
      await _storage.write(key: _keyLongitude, value: longitude.toString());

  static Future<String?> getLongitude() async {
    var longitude;
    await _storage.read(key: _keyLongitude).then((value) => longitude = value);
    return longitude;
  }



  static Future setUserId(String userId) async =>
      await _storage.write(key: _keyUserId, value: userId);

  static Future<String?> getUserId() async {
    var userId;
    await _storage.read(key: _keyUserId).then((value) => userId = value);
    return userId;
  }
  


  static Future<String?> removeToken() async {
    _storage.delete(key: _keyUsername);
    _storage.delete(key: _keyLatitude);
    _storage.delete(key: _keyLongitude);
    _storage.delete(key: _keyUserId);
    _storage.delete(key: _keyLoginTime);
    await _storage.delete(key: _keyToken);
    return null;
  }
}
