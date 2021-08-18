import 'package:flutter/material.dart';
import 'package:gdrive_flutter/models/auth.dart';
import 'package:gdrive_flutter/screens/auth/main.dart';
import 'package:gdrive_flutter/utils/ensure.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Ensure(
        future: Auth.helper(context).ensureInitialised(),
        builder: (ctx, isInitialised) {
          return isInitialised == true
              ? Scaffold(
                  appBar: AppBar(
                    leading: Auth.helper(context).avatar,
                    title: Text('Home'),
                    actions: [
                      IconButton(
                        onPressed: () async {
                          await Auth.helper(context).signOut();
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => AuthScreen()));
                        },
                        icon: Icon(Icons.logout_rounded),
                        tooltip: 'Logout',
                      ),
                    ],
                  ),
                  body: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text('Hello')],
                    ),
                  ),
                )
              : Scaffold(body: Text('Error'));
        });
  }
}
