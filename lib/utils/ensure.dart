import 'package:flutter/material.dart';

typedef Builder<T> = Widget Function(BuildContext, T);

class Ensure<T> extends StatelessWidget {
  final Builder<T?> builder;
  final Future<T?> future;

  const Ensure({required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<T?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Scaffold(body: Center(child: Text('Error')));
          }
          if (snapshot.hasData) {
            return builder(context, snapshot.data);
          }
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
