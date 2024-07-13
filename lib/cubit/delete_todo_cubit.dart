import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/cubit/common_state.dart';
import 'package:login/cubit/todo_event.dart';
import 'package:login/repository/note_repository.dart';

class DeleteTodoCubit extends Bloc<TodoEvent,CommonState> {
  final NoteRepository repository;
  DeleteTodoCubit({required this.repository}) : super(CommonInitialState()){
    on<DeleteTodoEvent>((event, emit) async{
      emit(CommonLoadingState());
    final res = await repository.deleteTodo(id: event.id);
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState(data: data)));
    });
  }
}
