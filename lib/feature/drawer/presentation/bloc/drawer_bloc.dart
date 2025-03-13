import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pva/feature/drawer/presentation/bloc/drawer_event.dart';
import 'package:pva/feature/drawer/presentation/bloc/drawer_state.dart';
import '../../domain/usecases/get_drawer_config.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final GetDrawerConfig getDrawerConfig;

  DrawerBloc({required this.getDrawerConfig}) : super(const DrawerInitial()) {
    on<LoadDrawerConfig>(_onLoadDrawerConfig);
  }

  Future<void> _onLoadDrawerConfig(
    LoadDrawerConfig event,
    Emitter<DrawerState> emit,
  ) async {
    emit(const DrawerLoading());
    try {
      final config = await getDrawerConfig();
      config.fold(
              (error)=> emit(DrawerError(error.toString())) ,
              (config) => emit(DrawerLoaded(config))
      );
    } catch (error) {
      emit(DrawerError(error.toString()));
    }
  }
}
