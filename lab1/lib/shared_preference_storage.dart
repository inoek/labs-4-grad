import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage.dart';

@Injectable()
class SharedPreferenceStorage implements LocalStorage {
  late SharedPreferences prefs;

  @override
  Future<void> delete(String key) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  @override
  Future<T?> read<T>(String key, {T? Function(String data)? decoder}) async {
    prefs = await SharedPreferences.getInstance();
    if (decoder != null) {
      final value = prefs.getString(key);
      if (value != null) {
        return decoder(value);
      } else {
        return null;
      }
    } else {
      if (prefs.getString(key) is String) {
        return prefs.getString(key) as T;
      } else {
        throw Exception('Value is not String');
      }
    }
  }

  @override
  Future<void> write(String key, value) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value.toString());
  }

  @override
  Future<void> clear() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
