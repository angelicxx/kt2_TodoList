import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/todo_bloc.dart';
import '../entities/todo.dart';

class CreateTodoScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить задачу'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Заголовок'),
            ),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final text = _textController.text.trim();
                if (title.isNotEmpty && text.isNotEmpty) {
                  final todo = Todo(title: title, text: text);
                  context.read<TodoBloc>().add(AddTodoEvent(todo));
                  Navigator.pop(context);
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
