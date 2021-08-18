import 'package:flutter/material.dart';
import 'package:gdrive_flutter/drive_helper.dart';
import 'package:provider/provider.dart';

class Auth extends ChangeNotifier {
  DriveHelper driveHelper;

  Auth(this.driveHelper);

  static Auth of(BuildContext context, {bool listen = false}) {
    return Provider.of<Auth>(context, listen: listen);
  }

  static DriveHelper helper(BuildContext context) {
    return of(context).driveHelper;
  }
}
