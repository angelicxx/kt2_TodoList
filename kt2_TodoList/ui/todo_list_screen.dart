import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/todo_bloc.dart';
import '../entities/todo.dart';
import 'create_todo_screen.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои задачи'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.todos.isEmpty) {
            return const Center(
              child: Text('Нет задач. Добавьте первую!'),
            );
          }
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration:
                        todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(todo.text),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) {
                    context.read<TodoBloc>().add(ToggleDoneEvent(todo.id));
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<TodoBloc>().add(RemoveTodoEvent(todo.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Задача удалена')),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}