import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../entities/todo.dart';

// События
abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class RemoveTodoEvent extends TodoEvent {
  final String id;

  RemoveTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleDoneEvent extends TodoEvent {
  final String id;

  ToggleDoneEvent(this.id);

  @override
  List<Object?> get props => [id];
}

// Состояние
class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState(this.todos);

  @override
  List<Object?> get props => [todos];
}

// BLoC
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState([])) {
    on<AddTodoEvent>((event, emit) {
      final newTodos = List<Todo>.from(state.todos)..add(event.todo);
      emit(TodoState(newTodos));
    });

    on<RemoveTodoEvent>((event, emit) {
      final newTodos = state.todos.where((todo) => todo.id != event.id).toList();
      emit(TodoState(newTodos));
    });

    on<ToggleDoneEvent>((event, emit) {
      final newTodos = state.todos.map((todo) {
        if (todo.id == event.id) {
          return todo.copyWith(isDone: !todo.isDone);
        }
        return todo;
      }).toList();
      emit(TodoState(newTodos));
    });
  }
}
