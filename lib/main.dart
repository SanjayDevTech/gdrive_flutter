import 'package:flutter/material.dart';
import 'package:gdrive_flutter/drive_helper.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'models/auth.dart';

void main() {
  final driveHelper = DriveHelper([DriveScopes.appData]);
  runApp(
    ChangeNotifierProvider(
      create: (context) => Auth(driveHelper),
      child: GDriveApp(),
    ),
  );
}
