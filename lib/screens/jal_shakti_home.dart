import 'package:flutter/material.dart';

import '../custom-widgets/introduction_card.dart';
import './survey_page.dart';

class JalShaktiHome extends StatelessWidget {
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
              // RaisedButton(
              //     child: Text('Capture picture'),
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) {
              //         return TakePictureScreen(camera: firstCamera) ;
              //       }));
              //     }),
              RaisedButton(
                child: Text('Start Survey'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Surveypage("no image");
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
