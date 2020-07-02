import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom-widgets/introduction_card.dart';
import './survey_page.dart';

class JalShaktiHome extends StatelessWidget {
  Future<http.Response> getDataFromServer() async {
    var response = await http
        .get("http://192.168.43.117:5000/getData")
        .catchError((error) {
      print("Error");
      print(error);
    });
    print('Response');
    print(response.body);
    return response;
  }

  printData() {
    print("I have this:");
    print(getDataFromServer());
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
                onPressed: //printData
                    () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Surveypage("no-image");
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
