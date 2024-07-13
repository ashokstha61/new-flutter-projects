import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/cubit/add_todo_cubit.dart';
import 'package:login/cubit/common_state.dart';
import 'package:login/cubit/delete_todo_cubit.dart';
import 'package:login/cubit/todo_event.dart';
import 'package:login/cubit/update_todo_cubit.dart';
import 'package:login/repository/note_repository.dart';

class FetchTodoCubit extends Bloc<FetchTodoEvent,CommonState> {
  final NoteRepository repo;
  AddTodoCubit addTodoCubit;
  StreamSubscription? addTodoSubscription;
  UpdateTodoCubit updateTodoCubit;
  StreamSubscription? updateTodoSubscription;
  DeleteTodoCubit deleteTodoCubit;
  StreamSubscription? deleteTodoSubscription;
  FetchTodoCubit({
    required this.repo, 
    required this.deleteTodoCubit,
    required this.addTodoCubit,
    required this.updateTodoCubit
    })
      : super(CommonInitialState()) {
    deleteTodoSubscription = deleteTodoCubit.stream.listen((event) {
      if (event is CommonSuccessState) {
        add(FetchTodoEvent());
     }
    });
     addTodoSubscription = addTodoCubit.stream.listen((event) {
      if (event is CommonSuccessState) {
        add(FetchTodoEvent());
     }
    });
     updateTodoSubscription = updateTodoCubit.stream.listen((event) {
      if (event is CommonSuccessState) {
        add(FetchTodoEvent());
        
     }
    });
    on<FetchTodoEvent>((event, emit) async{
       emit(CommonLoadingState());
    final res = await repo.fetchTodo();
    res.fold((err) => emit(CommonErrorState(message: err)),
        (data) => emit(CommonSuccessState(data: data)));
    });
  }

  @override
  Future<void> close() {
    deleteTodoSubscription?.cancel();
    addTodoSubscription?.cancel();
    updateTodoSubscription?.cancel();
    return super.close();
  }
}
