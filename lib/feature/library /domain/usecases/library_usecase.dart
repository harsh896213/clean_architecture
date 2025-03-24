import 'package:fpdart/src/either.dart';
import 'package:pva/core/network/api_error.dart';
import 'package:pva/core/usecase/usecase.dart';
import 'package:pva/feature/library%20/domain/entities/library_entity.dart';
import 'package:pva/feature/library%20/domain/repository/library_repository.dart';

class LibraryUseCase implements UseCase<LibraryEntity, int>{
  final LibraryRepository libraryRepository;

  const LibraryUseCase(this.libraryRepository);

  @override
  Future<Either<ApiError, LibraryEntity>> call(int params) {

    return libraryRepository.getLibraryData(params);
  }
}



