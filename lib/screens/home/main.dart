import 'package:flutter/material.dart';
import 'package:gdrive_flutter/models/auth.dart';
import 'package:gdrive_flutter/screens/home/content.dart';
import 'package:gdrive_flutter/utils/ensure.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Ensure(
        future: Auth.helper(context).ensureInitialised(),
        builder: (ctx, isInitialised) {
          return isInitialised == true
              ? Content()
              : Scaffold(body: Text('Error'));
        });
  }
}
