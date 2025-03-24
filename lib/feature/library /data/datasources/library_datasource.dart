import 'package:pva/feature/library%20/data/models/library_model.dart';

abstract class LibraryDataSource{
Future<LibraryModel> getLibraryData(int userId);
}

class LibraryDataSourceImpl implements LibraryDataSource{
  @override
  Future<LibraryModel> getLibraryData(int userId) {

    throw UnimplementedError();
  }

}