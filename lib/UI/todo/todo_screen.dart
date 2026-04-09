import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/bloc/todo/todo_bloc.dart';
import 'package:flutter_widgets/bloc/todo/todo_event.dart';
import 'package:flutter_widgets/bloc/todo/todo_state.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo List")),
      body: SafeArea(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state.todosList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_late_outlined,
                      size: 40,
                      color: Colors.grey[400],
                    ),

                    SizedBox(height: 12),

                    Text(
                      "No Tasks Yet",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "When you add a todo, it will appear here.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.todosList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.todosList[index]),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                          RemoveTodoEvent(task: state.todosList[index]),
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (int i = 0; i < 6; i++) {
            context.read<TodoBloc>().add(
              AddTodoEvent(task: 'task ${i.toString()}'),
            );
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
