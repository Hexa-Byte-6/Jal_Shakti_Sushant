import 'package:flutter/material.dart';

class PermissionRequestCard extends StatelessWidget {
  final Function getPermissions;
  PermissionRequestCard(this.getPermissions);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      alignment: Alignment.center,
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RichText(
                  text: TextSpan(
                      text: "Permissions",
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                          text: " Required!",
                          style: TextStyle(color: Colors.red[100]),
                        ),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Location: We require access to your location in order to correctly map the embankment data of your region"),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Camera: We require images of the embankment. Hence camera access is needed"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: getPermissions,
                child: Text(
                  "Allow",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue[300],
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
