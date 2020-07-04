import 'package:flutter/material.dart';
import 'package:jal_shakti_sush/custom-widgets/admin_drawer.dart';

class EmergencyReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Report"),
      ),
      drawer: AdminDrawer(),
      body: Center(
        child: Text("Emergency alert screen"),
      ),
    );
  }
}
