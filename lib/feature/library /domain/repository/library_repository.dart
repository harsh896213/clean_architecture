import 'package:fpdart/fpdart.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/feature/library%20/domain/entities/library_entity.dart';

abstract class LibraryRepository{
  Future<Either<ApiError, LibraryEntity>> getLibraryData(int use);
}