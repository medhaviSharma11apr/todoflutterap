import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();
  void setValue(String key, String value) {
    _box.write(key, value);
  }

  dynamic getValue(String key,) {
    return _box.read(key);
  }

  void clearAll() {
    _box.erase();
  }
}
