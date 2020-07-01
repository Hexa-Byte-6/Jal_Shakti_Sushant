import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../screens/camera_screen.dart';

class Surveypage extends StatefulWidget {
  final CameraDescription camera;
  Surveypage(this.camera);

  @override
  _SurveypageState createState() => _SurveypageState();
}

class _SurveypageState extends State<Surveypage> {
  @override
  Widget build(BuildContext context) {
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
            Text('Please capture a picture of the embankment where you see any fault'),
            RaisedButton(
                  child: Text('Click Picture'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TakePictureScreen(camera: widget.camera) ;
                    }));
                  }),
          ],
        ),
      ),
    );
  }
}
