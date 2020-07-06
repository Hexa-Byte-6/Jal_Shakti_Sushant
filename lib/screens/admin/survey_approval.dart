import 'package:flutter/material.dart';

import 'package:jal_shakti_sush/classes/survey_approval_data.dart';
import 'package:jal_shakti_sush/screens/admin/survey_approval_help.dart';
import 'package:jal_shakti_sush/screens/admin/survey_details.dart';

class SurveyApprovalScreen extends StatelessWidget {
  final surveys = PendingSurveys.surveys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approval"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ApprovalHelp();
                }));
              })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: surveys.length,
                  itemBuilder: (context, index) {
                    return SurveyDescriptionCard(
                        surveys[index]["user-name"],
                        surveys[index]["survey-date"],
                        surveys[index]["status"]);
                  }),
            )
          ],
        ),
      ),
    );
  }
}

class SurveyDescriptionCard extends StatelessWidget {
  final String user, date, status;
  SurveyDescriptionCard(this.user, this.date, this.status);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      height: 150,
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        shadowColor: this.status == "pending"
            ? Colors.redAccent
            : Colors.lightGreenAccent,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                  width: 4,
                  color: status == "pending" ? Colors.red : Colors.green),
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    child: status == "pending"
                        ? Icon(
                            Icons.error_outline,
                            color: Colors.orange,
                          )
                        : Icon(
                            Icons.done,
                            color: Colors.green,
                            semanticLabel: "Pending",
                          ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
                child: Text("Name : " + user),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, bottom: 5, top: 5),
                child: Text("Survey date : " + date),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: status == "pending"
                      ? GestureDetector(
                          onTap: () {
                            debugPrint("Approve icon clicked................");
                            //go to survey details screen
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SurveyDetails(user: user, date: date);
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Approve",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        )
                      : Text(
                          "Approved",
                          style: TextStyle(color: Colors.grey),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
