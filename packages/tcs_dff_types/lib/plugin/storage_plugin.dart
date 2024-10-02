import 'plugin_types.dart';

abstract interface class StoragePlugin implements Plugin {
  Future<void> setItem<T>({
    required final String collectionName,
    required final String key,
    required final T item,
  });

  Future<T?> getItem<T>({
   required final String collectionName,
    required final String key,
  });

  Future<Map<String, T?>> getAllItems<T>({
    required final String collectionName,
    required final List<String> keys,
  });

  Future<void> deleteItem<T>({
    required final String collectionName,
    required final String key,
  });

  Future<void> deleteAllItems<T>({
    required final String collectionName,
    required final List<String> keys,
  });

  Future<void> clearCollection<T>({required final String collectionName});

  Future<void> closeCollection<T>({required final String collectionName});
}
