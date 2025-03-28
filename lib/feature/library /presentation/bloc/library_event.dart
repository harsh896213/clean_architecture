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

  FilterLibrary();
}

class SelectFilterTile extends LibraryEvent{
  final String? selectedCategory;
  final String? selectedContentType;

  SelectFilterTile(
      { this.selectedCategory,  this.selectedContentType});

}

class ToggleAskedQuestion extends LibraryEvent{
 final  FrequentlyAskedQuestionEntity frequentlyAskedQuestion;

 ToggleAskedQuestion({required this.frequentlyAskedQuestion});
}

class DownloadDocument extends LibraryEvent{}

class RecommendedResourcesCLick extends LibraryEvent{}