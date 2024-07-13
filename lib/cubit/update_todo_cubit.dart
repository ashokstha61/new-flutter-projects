import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/cubit/common_state.dart';
import 'package:login/cubit/todo_event.dart';
import 'package:login/repository/note_repository.dart';

class UpdateTodoCubit extends Bloc<UpdateTodoEvent,CommonState> {
  final NoteRepository repository;
  UpdateTodoCubit({required this.repository}) : super(CommonInitialState()){
    on<UpdateTodoEvent>((event, emit) async{
      emit(CommonLoadingState());
    final res = await repository.updateTodo(title:event.title ,description: event.description,id: event.id);
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState(data: data)));
    });
  }
  
}
