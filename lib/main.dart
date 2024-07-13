import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:login/cubit/add_todo_cubit.dart';
import 'package:login/cubit/delete_todo_cubit.dart';
import 'package:login/cubit/fetch_todo_cubit.dart';
import 'package:login/cubit/todo_event.dart';
import 'package:login/cubit/update_todo_cubit.dart';
import 'package:login/repository/note_repository.dart';
import 'package:login/to_do/todo_listing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: RepositoryProvider(
        create: (context) => NoteRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => DeleteTodoCubit(
                    repository: context.read<NoteRepository>())),
                     BlocProvider(
                create: (context) =>
                    AddTodoCubit(repository: context.read<NoteRepository>())),
            BlocProvider(
                create: (context) => UpdateTodoCubit(
                    repository: context.read<NoteRepository>())),
            BlocProvider(
              create: (context) => FetchTodoCubit(
                  repo: context.read<NoteRepository>(),
                  deleteTodoCubit: context.read<DeleteTodoCubit>(),
                  addTodoCubit: context.read<AddTodoCubit>(),
                  updateTodoCubit: context.read<UpdateTodoCubit>()
                  )
                ..add(FetchTodoEvent()),
            ),
           
            
          ],
          child: MaterialApp(
            home: TodoListingScreen(),
          ),
        ),
      ),
    );
  }
}
