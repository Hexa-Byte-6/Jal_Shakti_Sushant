import 'package:flutter/material.dart';

class SurveyApprovalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approval"),
      ),
      body: Center(
        child: Text("Approve survey data"),
      ),
    );
  }
}
