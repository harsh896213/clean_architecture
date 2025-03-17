abstract class DatabaseRepository {
  Future<void> insert(Map<String, dynamic> data, String tableName);

  Future<List<Map<String, dynamic>>> getAll(String tableName);

  Future<void> close();

  Future<void> insertBatch<T>(List<T> objects, String tableName,
      Map<String, dynamic> Function(T) toMap);

  Future<List<T>> getPaginated<T>(int page, int pageSize, String tableName,
      T Function(Map<String, dynamic>) fromMap);
}
