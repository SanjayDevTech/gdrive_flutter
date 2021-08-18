import 'package:flutter/material.dart';

class DialogContent extends StatelessWidget {
  final _controller = TextEditingController();
  final Function(String) onPressed;

  DialogContent({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add todo item'),
      content: TextFormField(
        style: TextStyle(
          fontSize: 20,
        ),
        controller: _controller,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            onPressed(_controller.text);
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
