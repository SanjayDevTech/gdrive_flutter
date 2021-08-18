import 'package:flutter/material.dart';
import 'package:gdrive_flutter/models/todo.dart';

class TodoList extends StatefulWidget {
  final List<Todo> todos;
  final Function(List<Todo>) onChange;
  TodoList({required this.todos, required this.onChange});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todos.length,
      itemBuilder: (ctx, pos) {
        var todo = widget.todos[pos];
        return ListTile(
          key: ValueKey(todo.id),
          title: Text(todo.title),
          trailing: IconButton(
            onPressed: () {
              var newTodoList =
                  widget.todos.where((t) => t.id != todo.id).toList();
              widget.onChange(newTodoList);
            },
            icon: Icon(Icons.delete),
          ),
        );
      },
    );
  }
}
