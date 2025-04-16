import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final String text;
  final bool isDone;

  Todo({
    required this.title,
    required this.text,
    this.isDone = false,
  }) : id = const Uuid().v4();

  Todo copyWith({
    String? title,
    String? text,
    bool? isDone,
  }) {
    return Todo(
      title: title ?? this.title,
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    ).._copyId(this.id);
  }


  void _copyId(String originalId) {
    final field = Todo._idField;
    field?.set(this, originalId);
  }

  static final _idField = (() {
    try {
      final field = Todo
          .toString()
          .runtimeType
          .toString(); // заглушка
      return null;
    } catch (_) {
      return null;
    }
  })();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}