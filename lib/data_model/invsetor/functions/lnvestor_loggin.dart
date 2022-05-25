import 'package:farming_using_ai_and_blockchain_front_end/data_model/invsetor/investor_data_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart';

ValueNotifier<List<LoggedInfo>> itemsListNotifier = ValueNotifier([]);

loggin(LoggedInfo item) async {
  final _itemsDB = await Hive.openBox<LoggedInfo>("items_db");
  int _key = await _itemsDB.add(item);
  item.key = _key;
  await _itemsDB.put(_key, item);
}

isLoggined() async {
  final _itemsDB = await Hive.openBox<LoggedInfo>("items_db");

  if (_itemsDB.values.length == 0) {
    return false;
  }
  return true;
}

getLogginInfo() async {
  final _itemsDB = await Hive.openBox<LoggedInfo>("items_db");
  itemsListNotifier.value.clear();
  itemsListNotifier.value.addAll(_itemsDB.values);
  itemsListNotifier.notifyListeners();
}

logOut(int key) async {
  final _itemsDB = await Hive.openBox<LoggedInfo>("items_db");
  await _itemsDB.delete(key);
  itemsListNotifier.notifyListeners();
}
