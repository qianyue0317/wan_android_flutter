

import 'dart:convert';

import 'package:mmkv/mmkv.dart';
import 'package:wan_android_flutter/network/bean/user_info_entity.dart';
import 'package:wan_android_flutter/utils/log_util.dart';

typedef LoginStatusChangeCallback = void Function();

class User {
  static const String _userInfoKey = "userInfo";

  User._internal();

  static final User _singleton = User._internal();

  factory User() => _singleton;

  UserInfoEntity? _userInfoEntity;

  bool isLoggedIn() => _userInfoEntity != null;

  String get userName => _userInfoEntity!.username;

  int get userCoinCount => _userInfoEntity!.coinCount;

  final List<LoginStatusChangeCallback> _list = [];

  on(LoginStatusChangeCallback loginStatusChange) {
    _list.add(loginStatusChange);
  }

  off(LoginStatusChangeCallback loginStatusChange) {
    _list.remove(loginStatusChange);
  }

  loadFromLocal() {
    try {
      MMKV mmkv = MMKV.defaultMMKV();
      String? infoContent = mmkv.decodeString(_userInfoKey);
      if (infoContent == null) {
        return;
      }
      _userInfoEntity = UserInfoEntity.fromJson(json.decoder.convert(infoContent));
    } catch(e) {
      WanLog.e("load user info from local error- $e");
    }
  }

  loginSuccess(UserInfoEntity userInfoEntity) {
    _userInfoEntity = userInfoEntity;
    try {
      MMKV mmkv = MMKV.defaultMMKV();
      String infoContent = _userInfoEntity.toString();
      mmkv.encodeString(_userInfoKey, infoContent);
    } catch(e) {
      WanLog.e("save user info to local error- $e");
    }
    for (var callback in _list) {
      callback();
    }
  }

  logout() {
    for (var callback in _list) {
      callback();
    }
  }
}