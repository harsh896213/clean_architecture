import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pva/feature/library%20/domain/entities/document.dart';
import 'package:pva/feature/library%20/domain/entities/frequently_asked_question.dart';
import 'package:pva/feature/library%20/domain/entities/resource.dart';
import 'package:pva/feature/library%20/domain/usecases/library_usecase.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {

  final LibraryUseCase libraryUseCase;

  LibraryBloc({required this.libraryUseCase}) : super(LibraryInitial()) {

    on<GetLibraryData>((event, emit) => _getLibraryData(event, emit));
    on<SearchResources>((event, emit) => _searchResources(event, emit));
    on<FilterLibrary>((event, emit) => _filterLibrary(event, emit));
    on<DownloadDocument>((event, emit) => _downloadDocument(event, emit));
    on<ToggleAskedQuestion>((event, emit) => _toggleAskedQuestion(event, emit));
  }

  void _getLibraryData(GetLibraryData event, Emitter<LibraryState> emit) async{

   final res = await libraryUseCase(5);

   res.fold(
         (failure) => emit(ResourcesFailure(message: failure.message)),
        (success) => emit(LibraryDataState(
            resource: success.resources,
            document: success.document,
            askedQuestion: success.frequentlyAskedQuestion,
            filterResources: success.resources,
            filterAskedQuestion:success.frequentlyAskedQuestion,
            filterDocument: success.document,
        )));

  }

  void _searchResources(SearchResources event, Emitter<LibraryState> emit) {

    if(state is! LibraryDataState) return;

    var libraryDataState = state as LibraryDataState;

    if(event.searchText.trim().isEmpty){
      emit(libraryDataState.copyWith(
          filterResources: libraryDataState.resource,
          filteredDocument: libraryDataState.document,
          filteredAskedQuestion: libraryDataState.askedQuestion));
      return;
    }
    var filterList = libraryDataState.resource.where(
      (element) =>
          element.title.toLowerCase().contains(event.searchText.toLowerCase()),
    ).toList();

    var filterDocument = libraryDataState.document.where(
      (element) =>
          element.title.toLowerCase().contains(event.searchText.toLowerCase()),
    ).toList();

    var filterQuestion = libraryDataState.askedQuestion.where(
      (element) =>
          element.title.toLowerCase().contains(event.searchText.toLowerCase()),
    ).toList();

    emit(libraryDataState.copyWith(
        filterResources: filterList,
        filteredDocument: filterDocument,
        filteredAskedQuestion: filterQuestion));
  }

  void _filterLibrary(FilterLibrary event, Emitter<LibraryState> emit) {
    if(state is! LibraryDataState) return;

    var currentState = state as LibraryDataState;

    var filterResource = currentState.resource
        .where(
          (element) => element.documentType.toString() == event.selectedCategory,
        ).toList();


    emit(currentState.copyWith(filterResources: filterResource));
  }

  void _downloadDocument(DownloadDocument event, Emitter<LibraryState> emit) {

  }

  void _toggleAskedQuestion(ToggleAskedQuestion event, Emitter<LibraryState> emit) {
    if(state is! LibraryDataState) return;

    var currentState = state as LibraryDataState;

     var updatedValue = currentState.askedQuestion.map((e) {
      if(e.title == event.frequentlyAskedQuestion.title){
        e.isOpen = !e.isOpen;
      }
      else{
        e.isOpen = false;
      }
      return e;
    }).toList();

    emit(currentState.copyWith(filteredAskedQuestion: updatedValue));
  }

}
