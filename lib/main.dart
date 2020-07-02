import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'package:jal_shakti_sush/screens/jal_shakti_home.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    usePreferences: false,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var permissions = false;
  getPermissions() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.location, Permission.camera].request();
    print(statuses[Permission.location]);
    print(statuses[Permission.camera]);
    if (statuses[Permission.camera].isGranted &&
        statuses[Permission.location].isGranted) {
      setState(() {
        permissions = true;
      });
    } else {
      setState(() {
        permissions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!permissions) {
      getPermissions();
      return Text("Permissions required");
    } else {
      return MaterialApp(
        title: 'Jal SHakti',
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: new JalShaktiHome(),
      );
    }
  }
}
