import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  String name = "TestBloc";
  TestBloc() : super(TestInitial()) {
    on<TestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
