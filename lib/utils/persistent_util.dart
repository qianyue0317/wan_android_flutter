
import 'package:mmkv/mmkv.dart';

class Persistent {
  var mmkv = MMKV.defaultMMKV();

  void encodeBool(String key, bool value) {
    mmkv.encodeBool(key, value);
  }

  void encodeString(String key, String value) {
    mmkv.encodeString(key, value);
  }

  void encodeInt(String key, int value) {
    mmkv.encodeInt(key, value);
  }

  bool decodeBool(String key, {bool defaultValue = false}) {
    return mmkv.decodeBool(key, defaultValue: defaultValue);
  }

  String? decodeString(String key) {
    return mmkv.decodeString(key);
  }

  int decodeInt(String key, {int defaultValue = 0}) {
    return mmkv.decodeInt(key, defaultValue: defaultValue);
  }
}