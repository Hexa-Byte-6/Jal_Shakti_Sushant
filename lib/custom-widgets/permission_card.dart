import 'package:flutter/material.dart';

class PermissionRequestCard extends StatelessWidget {
  final Function getPermissions;
  PermissionRequestCard(this.getPermissions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text("Please allow the following permission:"),
            Text(
                "Location: We require access to your location in order to correctly map the embankment data of your region"),
            Text(
                "Camera: We require images of the embankment. Hence camera access is needed"),
            RaisedButton(
              onPressed: getPermissions,
              child: Text("Allow"),
            )
          ],
        ),
      ),
    );
  }
}
