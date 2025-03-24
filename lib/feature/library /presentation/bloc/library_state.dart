part of 'library_bloc.dart';

@immutable
sealed class LibraryState {}

final class LibraryInitial extends LibraryState {}

class ResourcesSuccess extends LibraryState{}

class ResourcesFailure extends LibraryState{
  final String message;

  ResourcesFailure({required this.message});
}

class QuestionSuccess extends LibraryState{}


class LibraryDataState extends LibraryState{
  final List<Resource> resource;
  final List<Resource> filterResources;
  final List<DocumentEntity> document;
  final List<DocumentEntity> filterDocument;
  final List<FrequentlyAskedQuestionEntity> askedQuestion;
  final List<FrequentlyAskedQuestionEntity> filterAskedQuestion;

  LibraryDataState(
      {
      required this.resource,
      required this.document,
      required this.askedQuestion,
      this.filterResources = const [],
      this.filterDocument = const [],
      this.filterAskedQuestion = const []
      });

  LibraryDataState copyWith({
    List<Resource>? resource,
    List<Resource>? filterResources,
    List<DocumentEntity>? document,
    List<DocumentEntity>? filteredDocument,
    List<FrequentlyAskedQuestionEntity>? askedQuestion,
    List<FrequentlyAskedQuestionEntity>? filteredAskedQuestion,
  }){
    return LibraryDataState(
        resource: resource ?? this.resource,
        filterResources: filterResources ?? this.filterResources,
        document: document ?? this.document,
        filterDocument: filteredDocument ?? this.filterDocument,
        filterAskedQuestion: filteredAskedQuestion ?? this.filterAskedQuestion,
        askedQuestion: askedQuestion ?? this.askedQuestion,
    );
  }

}









