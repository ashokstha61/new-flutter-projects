abstract class TodoEvent{}
class AddTodoEvent extends TodoEvent{
  final String title;
  final String description;
  AddTodoEvent({required this.title, required this.description});
}
class DeleteTodoEvent extends TodoEvent{ 
  final String id;
  DeleteTodoEvent({required this.id});
 }
class UpdateTodoEvent extends TodoEvent{
  final String title;
  final String description;
  final String id;
  UpdateTodoEvent({required this.title, required this.description, required this.id});
}
class FetchTodoEvent extends TodoEvent{}