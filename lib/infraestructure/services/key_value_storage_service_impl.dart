
import 'package:ghanta/infraestructure/services/key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> _getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await _getSharedPrefs();
    
    switch (T) {
      case int:
        return prefs.getInt(key) as T?;
      case double:
        return prefs.getDouble(key) as T?;
      case String:
        return  prefs.getString(key) as T?;
      case bool:
        return prefs.getBool(key) as T?;
      case List:
        return prefs.getStringList(key) as T?;
      default:
        throw UnimplementedError('Tipo de dato no soportado ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await _getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await _getSharedPrefs();

    switch (T) {
      case int:
        await prefs.setInt(key, value as int);
        break;
      case double:
        await prefs.setDouble(key, value as double);
        break;
      case String:
        await prefs.setString(key, value as String);
        break;
      case bool:
        await prefs.setBool(key, value as bool);
        break;
      case List:
        await prefs.setStringList(key, value as List<String>);
        break;
      default:
        throw UnimplementedError('Tipo de dato no soportado ${T.runtimeType}');
    }
  }
}
