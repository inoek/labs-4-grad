abstract class LocalStorage {
  Future<T?> read<T>(String key, {T? Function(String data)? decoder});

  Future<void> write(String key, dynamic value);

  Future<void> delete(String key);

  Future<void> clear();
}
