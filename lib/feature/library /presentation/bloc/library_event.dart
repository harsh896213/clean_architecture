part of 'library_bloc.dart';

@immutable
sealed class LibraryEvent {

}

class GetLibraryData extends LibraryEvent{}

class SearchResources extends LibraryEvent{
  final String searchText;

  SearchResources({required this.searchText});
}

class FilterLibrary extends LibraryEvent{
  final String selectedContentType;
  final String selectedCategory;

  FilterLibrary(
      {required this.selectedContentType, required this.selectedCategory});
}

class ToggleAskedQuestion extends LibraryEvent{
 final  FrequentlyAskedQuestionEntity frequentlyAskedQuestion;

 ToggleAskedQuestion({required this.frequentlyAskedQuestion});
}

class DownloadDocument extends LibraryEvent{}

class RecommendedResourcesCLick extends LibraryEvent{}