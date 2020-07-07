import 'package:flutter/material.dart';
import 'package:jal_shakti_sush/classes/localization/localization.dart';
import 'package:jal_shakti_sush/screens/admin/emergency_report_screen.dart';
import 'package:jal_shakti_sush/screens/admin/survey_approval.dart';
import 'package:jal_shakti_sush/screens/jal_shakti_home.dart';
import 'package:jal_shakti_sush/screens/more_info.dart';
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
                    // ListTile(
                    //   title: Text("Home"),
                    //   trailing: Icon(Icons.home),
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (BuildContext context) {
                    //       return JalShaktiHome();
                    //     }));
                    //   },
                    // ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).approveSurveys),
                      trailing: Icon(Icons.assignment_turned_in),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return SurveyApprovalScreen();
                        }));
                      },
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).survey),
                      trailing: Icon(Icons.assignment),
                      onTap: () {
                        Navigator.of(context).pop();

                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Surveypage("no-image");
                        }));
                      },
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).reportProblem),
                      trailing: Icon(Icons.error_outline),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return EmergencyReport();
                        }));
                      },
                    ),
                    Divider(
                      endIndent: 10,
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).about),
                      trailing: Icon(Icons.help_outline),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MoreInfo();
                          }),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(AppLocalizations.of(context).signOut),
                      trailing: Icon(Icons.power_settings_new),
                      onTap: () {
                        Navigator.of(context).pop();
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
