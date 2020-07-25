import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:jal_shakti_sush/classes/localization/localization.dart';
import 'package:jal_shakti_sush/screens/fullscreen_image.dart';

class SurveyDetails extends StatelessWidget {
  final String user, date;
  var url =
      "https://images.unsplash.com/photo-1497250681960-ef046c08a56e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";

  final imageUrl;
  final location;

  SurveyDetails({this.user, this.date, this.imageUrl, this.location});

  _showConfirmationDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure?"),
            content:
                Text("This data will be stored into database as valid data"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  //discard the survey data and remove it from database
                },
                child: Text("No"),
              ),
              FlatButton(
                onPressed: () {
                  //update status of survey as approved in the database
                },
                child: Text("Yes"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //Widget to display user details
    final surveyDetailsHeader = Container(
      height: 100,
      width: double.maxFinite,
      child: Container(
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(width: 4, color: Colors.blue),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 10, left: 20),
                  child: Text(
                      AppLocalizations.of(context).surveyer + " : " + user),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 10, left: 20),
                  child: Text(
                      AppLocalizations.of(context).surveyDate + " : " + date),
                ),
              ],
            ),
          ),
        ),
      ),
    );

//Widget to hold surveyed image
    final surveyImage = Container(
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
              child: GestureDetector(
                onTap: () {
                  debugPrint("Image:$imageUrl");
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullScreenImage(imageUrl: url);
                  }));
                },
                child: Hero(
                  tag: "fullImage",
                  child: Image.network(
                    url,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final imageLocationDetails = Container(
      width: double.maxFinite,
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: Colors.blue),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                        ),
                        child: Text(AppLocalizations.of(context).imageLocation),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          bottom: 10,
                        ),
                        child: Text(
                          "${location['latitude']},${location['longitude']}",
                          style: TextStyle(color: Colors.lightBlueAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: RaisedButton(
                    child: Text(AppLocalizations.of(context).seeOnMap),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(width: 2, color: Colors.blue),
                    ),
                    onPressed: () async {
                      final String googleMapsUrl =
                          "https://www.google.com/maps/search/?api=1&query=${location['latitude']},${location['longitude']}";

                      final String appleMapsUrl =
                          "https://maps.apple.com/?q=${location['latitude']},${location['longitude']}";

                      if (Platform.isAndroid) {
                        if (await canLaunch(googleMapsUrl)) {
                          await launch(googleMapsUrl);
                        }
                      }
                      if (Platform.isIOS) {
                        if (await canLaunch(appleMapsUrl)) {
                          await launch(appleMapsUrl, forceSafariVC: false);
                        }
                      } else {
                        debugPrint("Couldn't launch URL");
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final approvalWarning = Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.orangeAccent,
            ),
            Expanded(
              child: Text(
                AppLocalizations.of(context).surveyApprovalWarning,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );

    final approvalSection = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: RaisedButton(
            child: Text(AppLocalizations.of(context).deny),
            color: Colors.white,
            elevation: 5,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text(
              AppLocalizations.of(context).approve,
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            elevation: 5,
            onPressed: () {
              //approve the survey and update its status in database
              _showConfirmationDialogBox(context);
            },
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            surveyDetailsHeader,
            surveyImage,
            imageLocationDetails,
            approvalWarning,
            approvalSection,
          ],
        ),
      ),
    );
  } //build

}
