import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdrive_flutter/drive_helper.dart';
import 'package:uuid/uuid.dart';

import 'package:gdrive_flutter/models/auth.dart';
import 'package:gdrive_flutter/models/todo.dart';
import 'package:gdrive_flutter/screens/auth/main.dart';
import 'package:gdrive_flutter/screens/home/todolist.dart';

import 'dialog.dart';

final uuid = Uuid();

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  late List<Todo> _todos;
  late DriveHelper _helper;

  void onChange(List<Todo> todos) {
    setState(() {
      _todos = todos;
    });
  }

  @override
  void initState() {
    super.initState();
    _todos = [];
    _helper = Auth.helper(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Auth.helper(context).avatar,
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_rounded),
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              try {
                var fileName = 'crm.json';
                var fileIds = await _helper.getFileID(fileName);
                var jsonString = jsonEncode(_todos);
                if (fileIds.isEmpty) {
                  debugPrint('if check');
                  await _helper.createFile(fileName, FileMimeTypes.file,
                      text: jsonString);
                } else {
                  debugPrint('else check');
                  await _helper.updateFile(fileIds[0], jsonString);
                }
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('Updated'),
                    action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {
                          messenger.clearSnackBars();
                        }),
                  ),
                );
              } catch (e) {
                debugPrint('$e');
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('Error: $e'),
                    action: SnackBarAction(
                        label: 'Dismiss',
                        onPressed: () {
                          messenger.clearSnackBars();
                        }),
                  ),
                );
              }
            },
          ),
          IconButton(
            onPressed: () async {
              await Auth.helper(context).signOut();
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => AuthScreen()));
            },
            icon: Icon(Icons.logout_rounded),
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => DialogContent(
              onPressed: (title) {
                _todos.add(Todo(uuid.v1(), title));
                onChange(_todos);
              },
            ),
          );
        },
      ),
      body: Container(
        width: double.infinity,
        child: TodoList(todos: _todos, onChange: onChange),
      ),
    );
  }
}
