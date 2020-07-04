import 'package:flutter/material.dart';
import 'package:jal_shakti_sush/custom-widgets/admin_drawer.dart';

class SurveyApprovalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Approval"),
      ),
      drawer: AdminDrawer(),
      body: Center(
        child: Text("Approve survey data"),
      ),
    );
  }
}
