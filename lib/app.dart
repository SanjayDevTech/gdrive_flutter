import 'package:flutter/material.dart';
import 'package:gdrive_flutter/models/auth.dart';
import 'package:gdrive_flutter/screens/auth/main.dart';
import 'package:gdrive_flutter/screens/home/main.dart';
import 'package:gdrive_flutter/utils/ensure.dart';

class GDriveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter GDrive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Ensure(
        future: Auth.helper(context).loggedIn,
        builder: (ctx, isLoggedIn) =>
            isLoggedIn == true ? HomeScreen() : AuthScreen(),
      ),
    );
  }
}
