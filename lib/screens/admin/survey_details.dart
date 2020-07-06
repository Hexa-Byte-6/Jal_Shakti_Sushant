import 'package:flutter/material.dart';
import 'package:jal_shakti_sush/screens/fullscreen_image.dart';

class SurveyDetails extends StatelessWidget {
  final String user, date;
  //final imageUrl = "https://picsum.photos/250?image=9";
  final imageUrl =
      "https://images.unsplash.com/photo-1497250681960-ef046c08a56e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60";

  SurveyDetails({
    this.user,
    this.date,
  });

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
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 10, left: 20),
              child: Text("Survey from: " + user),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10, left: 20),
              child: Text("Date: " + date),
            ),
          ],
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullScreenImage(imageUrl: imageUrl);
                  }));
                },
                child: Hero(
                  tag: "fullImage",
                  child: Image.network(
                    imageUrl,
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
                "Before approving the survey data, ensure it is correct and relevant to river embankments as per your knowledge.",
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
            child: Text("Deny"),
            color: Colors.white,
            elevation: 5,
            onPressed: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text(
              "Approve",
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
            approvalWarning,
            approvalSection,
          ],
        ),
      ),
    );
  } //build

}
