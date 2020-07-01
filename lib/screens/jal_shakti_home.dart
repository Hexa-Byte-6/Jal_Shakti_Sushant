import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import '../screens/camera_screen.dart';
import '../custom-widgets/introduction_card.dart';
import './survey_page.dart';

CameraDescription firstCamera;

Future initialize() async{
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

}


class JalShaktiHome extends StatelessWidget {

  JalShaktiHome(){
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Jal Shakti'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: IntroductionCard(),
              ),
              RaisedButton(
                  child: Text('Capture picture'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TakePictureScreen(camera: firstCamera) ;
                    }));
                  }),
              RaisedButton(
                child: Text('Start Survey'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Surveypage(firstCamera);
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
