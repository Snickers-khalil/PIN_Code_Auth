import 'package:hive_flutter/hive_flutter.dart';

abstract class PINRepository{
  void close();
  void addPin(String pin);
  Future<bool> pinEquals (String pin);
}

class HivePINRepository extends PINRepository{
  static const String _boxName = "PIN_BOX";
  static const String _keyName = "PIN_Key";

  @override
  void addPin(String pin) async {
    Box<String> box = Hive.isBoxOpen(_boxName) ? Hive.box(_boxName) : await Hive.openBox(_boxName);
    box.put(_keyName,pin);
  }

  @override
  Future<bool> pinEquals(String pin) async {
    Box<String> box = Hive.isBoxOpen(_boxName) ? Hive.box(_boxName) : await Hive.openBox(_boxName);

    return box.get(_keyName, defaultValue: _keyName) == pin;
  }

  @override
  void close() async {
    if (Hive.isBoxOpen(_boxName)) {
      Box<String> box = await Hive.box(_boxName);
      var v = await box.close();
      return v;
      //return await Hive.box(_boxName).close();
    }
  }
}