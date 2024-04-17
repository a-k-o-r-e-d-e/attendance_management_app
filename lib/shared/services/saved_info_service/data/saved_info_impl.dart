import 'dart:async';
import 'dart:convert';
import 'package:attendance_management_app/shared/services/saved_info_service/domain/repository/saved_info_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SavedInfoImpl extends SavedInfoService {
  final FlutterSecureStorage secureStorage;

  SavedInfoImpl(this.secureStorage);

  @override
  Future<bool> removeInfo(String key) async {
    try {
      await secureStorage.delete(key: key);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  Future<bool> saveInfo(String key, Object data) async {
    try {
      await secureStorage.write(key: key, value: json.encode(data));
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  @override
  Future<Object?> getInfo(String key) async {
    try {
      var user =
          jsonDecode(await secureStorage.read(key: key) ?? jsonEncode(null));
      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await secureStorage.deleteAll();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Future<bool> has(String key) {
    // TODO: implement has
    throw UnimplementedError();
  }
}
