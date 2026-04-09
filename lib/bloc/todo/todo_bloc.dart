import 'package:bloc/bloc.dart';
import 'package:flutter_widgets/bloc/todo/todo_event.dart';
import 'package:flutter_widgets/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<String> todoList = [];
  TodoBloc() : super(const TodoState()) {
    on<AddTodoEvent>(addTodo);
    on<RemoveTodoEvent>(removeTodo);
  }

  void addTodo(AddTodoEvent event, Emitter<TodoState> emit) {
    todoList.add(event.task);
    emit(state.copyWith(todosList: List.from(todoList)));
  }

  void removeTodo(RemoveTodoEvent event, Emitter<TodoState> emit) {
    todoList.remove(event.task);
    emit(state.copyWith(todosList: List.from(todoList)));
  }
}
