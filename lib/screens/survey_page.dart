import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../screens/camera_screen.dart';

CameraDescription firstCamera;

Future initialize() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;
}

class Surveypage extends StatefulWidget {
  final String imagePath;
  Surveypage(this.imagePath) {
    initialize();
    debugPrint("Camera initialized..........");
  }

  @override
  _SurveypageState createState() => _SurveypageState(imagePath);
}

class _SurveypageState extends State<Surveypage> {
  var image;
  _SurveypageState(this.image);
  @override
  Widget build(BuildContext context) {
    var _location = "234.56N";
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          children: <Widget>[
            Text('1/20'),
            Text(
                'Please capture a picture of the embankment where you see any fault'),
            RaisedButton(
                child: Text('Click Picture'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TakePictureScreen(camera: firstCamera);
                  }));
                }),
            Container(
              child: image == "no-image"
                  ? Text('No image captured')
                  : Image.file(
                      File(image),
                      width: 200,
                      height: 200,
                    ),
            ),
            Text(
                'We need your location, please fetch the current location by clicking below button'),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child:
                        RaisedButton(child: Text('Location'), onPressed: () {}),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(_location),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
