import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:jal_shakti_sush/custom-widgets/permission_card.dart';
import 'package:permission_handler/permission_handler.dart';

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
  var _image;
  var permissions = false;
  Map<String, String> _location = {};
  //_SurveypageState(this._image);
  _SurveypageState(imagePath) {
    this._image = imagePath;
    _location = {"latitude": "0.0", "longitude": "0.0"};
  }

  setImagePath(imagePath) {
    setState(() {
      _image = imagePath;
    });
    this._image = imagePath;
    print("Image path(survey page): " + this._image);
  }

  getPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.microphone
    ].request();
    //print(statuses[Permission.location]);
    //print(statuses[Permission.camera]);
    if (statuses[Permission.camera].isGranted &&
        statuses[Permission.location].isGranted &&
        statuses[Permission.microphone].isGranted) {
      setState(() {
        permissions = true;
      });
    } else {
      setState(() {
        permissions = false;
      });
    }
  }

  fetchLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude.toString() + ":" + position.longitude.toString());
    setState(() {
      _location["latitude"] = position.latitude.toString();
      _location["longitude"] = position.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey'),
      ),
      body: permissions
          ? Container(
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TakePictureScreen(
                              camera: firstCamera, setImage: setImagePath);
                        }));
                      }),
                  Container(
                    child: _image == "no-image"
                        ? Text('No image captured')
                        : Image.file(
                            File(_image),
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
                          child: RaisedButton(
                              child: Text('Location'),
                              onPressed: fetchLocation),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text("Latitude: " +
                              _location["latitude"] +
                              "\nLongitude:" +
                              _location["longitude"]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : PermissionRequestCard(getPermissions),
    );
  }
}
