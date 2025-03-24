import 'package:pva/feature/library%20/domain/entities/document.dart';
import 'package:pva/feature/library%20/domain/entities/frequently_asked_question.dart';
import 'package:pva/feature/library%20/domain/entities/resource.dart';

class LibraryEntity {
  final List<Resource> resources;
  final List<DocumentEntity> document;
  final List<FrequentlyAskedQuestionEntity> frequentlyAskedQuestion;

  LibraryEntity(
      {required this.resources,
      required this.document,
      required this.frequentlyAskedQuestion});
}