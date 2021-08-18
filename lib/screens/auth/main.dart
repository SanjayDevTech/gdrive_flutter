import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:gdrive_flutter/drive_helper.dart';
import 'package:gdrive_flutter/models/auth.dart';
import 'package:gdrive_flutter/screens/home/main.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _loading = false;
  late DriveHelper _driveHelper;

  @override
  void initState() {
    super.initState();
    _driveHelper = Auth.helper(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SignInButton(
                    Buttons.Google,
                    text: 'Sign in with Google',
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      try {
                        await _driveHelper.signInWithGoogle();
                        setState(() {
                          _loading = false;
                        });
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => HomeScreen()));
                      } catch (e) {
                        setState(() {
                          _loading = false;
                        });
                        final messenger = ScaffoldMessenger.of(context);
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
                  )
                ],
              ),
            ),
    );
  }
}
