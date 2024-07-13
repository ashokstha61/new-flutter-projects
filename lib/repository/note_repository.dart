import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:login/constants/urls.dart';
import 'package:login/to_do/todo.dart';

class NoteRepository {
  final dio = Dio();
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  Future<Either<String, List<Todo>>> fetchTodo() async {
    try {
      if(_todos.isNotEmpty)
      {
        return Right(_todos);
      }
      final response = await dio.get(Urls.url);
      final convertedList = List.from(response.data["data"]);
      final data = convertedList
          .map(
            (e) => Todo.fromMap(e),
          )
          .toList();
      _todos.clear();
      _todos.addAll(data);
      return Right(_todos);
    } on DioException catch (e) {
      return left(e.response?.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, List<Todo>>> addTodo(
      {required String title, required String description}) async {
    try {
      final res = await dio
          .post(Urls.url, data: {"title": title, "description": description});
          final _newTodo=Todo.fromMap(res.data["data"]);
          _todos.add(_newTodo);
      return Right(_todos);
    } on DioException catch (e) {
      return left(e.response?.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }
  Future<Either<String, List<Todo>>> updateTodo(
      {required String title, required String description,required String id}) async {
    try {
      final res =
       await dio.put("${Urls.url}/$id", data: {
        "title": title,
        "description":description
      });
        int index=0;
        index=_todos.indexWhere((element) => element.id==id);
        if(index!=-1)
        {
          _todos[index]=Todo.fromMap(res.data["data"]);
        }
        else{

        }
      return Right(_todos);
    } on DioException catch (e) {
      return left(e.response?.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }
   Future<Either<String, List<Todo>>> deleteTodo(
      {required String id}) async {
    try {
      dio.delete(
        "${Urls.url}/${id}",
      );
       _todos.removeWhere((element) => element.id==id);
      return Right(_todos);
    } on DioException catch (e) {
      return left(e.response?.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

}
