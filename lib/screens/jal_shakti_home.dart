import 'package:flutter/material.dart';

import 'package:jal_shakti_sush/custom-widgets/admin_drawer.dart';
import '../custom-widgets/introduction_card.dart';
import './survey_page.dart';

class JalShaktiHome extends StatefulWidget {
  @override
  _JalShaktiHomeState createState() => _JalShaktiHomeState();
}

class _JalShaktiHomeState extends State<JalShaktiHome> {
  final String user = "admin";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: user == "admin" ? AdminDrawer() : null,
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
                child: Text('Start Survey'),
                onPressed: () {
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
