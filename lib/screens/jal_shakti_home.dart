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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AdminDrawer(),
        // drawer: user == "admin"
        //     ? AdminDrawer()
        //     : Visibility(
        //         child: Drawer(),
        //         visible: false,
        //       ),
        appBar: AppBar(
          title: Text('Jal Shakti'),
          leading: user != "admin"
              ? Container()
              : IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
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
