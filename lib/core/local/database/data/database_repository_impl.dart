import 'package:pva/core/local/database/domain/database_repository.dart';

import 'database_helper.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseHelper _databaseHelper;

  DatabaseRepositoryImpl(this._databaseHelper);

  @override
  Future<void> insert(Map<String, dynamic> data, String tableName) {
    return _databaseHelper.insert(data, tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> getAll(String tableName) {
    return _databaseHelper.getAll(tableName);
  }

  @override
  Future<void> close() {
    return _databaseHelper.close();
  }

  @override
  Future<void> insertBatch<T>(List<T> objects, String tableName,
      Map<String, dynamic> Function(T) toMap) {
    return _databaseHelper.insertBatch(objects, tableName, toMap);
  }

  @override
  Future<List<T>> getPaginated<T>(int page, int pageSize, String tableName,
      T Function(Map<String, dynamic>) fromMap) {
    return _databaseHelper.getPaginated(page, pageSize, tableName, fromMap);
  }
}
