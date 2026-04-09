import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> todosList;
  const TodoState({this.todosList = const []});

  TodoState copyWith({List<String>? todosList}) {
    return TodoState(todosList: todosList ?? this.todosList);
  }

  @override
  List<Object?> get props => [todosList];
}
