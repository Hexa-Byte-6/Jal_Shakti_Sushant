import 'package:flutter/material.dart';
import 'package:jal_shakti_sush/screens/admin/emergency_report_screen.dart';
import 'package:jal_shakti_sush/screens/admin/survey_approval.dart';
import 'package:jal_shakti_sush/screens/jal_shakti_home.dart';
import 'package:jal_shakti_sush/screens/survey_page.dart';

class AdminDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        child: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: DrawerHeader(
                    child: Text("Admin"),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      title: Text("Home"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return JalShaktiHome();
                        }));
                      },
                    ),
                    ListTile(
                      title: Text("Video Approval"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return SurveyApprovalScreen();
                        }));
                      },
                    ),
                    ListTile(
                      title: Text("Survey"),
                      onTap: () {
                        Navigator.pop(context);
                        debugPrint("Survey item tapped");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          debugPrint("Going to survey page");
                          return Surveypage("no-image");
                        }));
                      },
                    ),
                    ListTile(
                      title: Text("Emergency alert"),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EmergencyReport();
                        }));
                      },
                    ),
                    ListTile(
                      title: Text("Sign out"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
