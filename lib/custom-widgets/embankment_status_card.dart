import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jal_shakti_sush/classes/Constants.dart';
import 'package:jal_shakti_sush/classes/location_accessor.dart';

class EmbankmentStatusCard extends StatefulWidget {
  @override
  _EmbankmentStatusCardState createState() => _EmbankmentStatusCardState();
}

class _EmbankmentStatusCardState extends State<EmbankmentStatusCard>
    with SingleTickerProviderStateMixin {
  AnimationController _refreshAnimator;
  String _embankmentStatus = "Safe";

  @override
  void initState() {
    _refreshAnimator = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));

    super.initState();
  }

  @override
  void dispose() {
    _refreshAnimator.dispose();
    super.dispose();
  }

  Future<String> _getEmbankmentStatus() async {
    //get status from server
    LocationAccessor loc = LocationAccessor();
    if (await loc.fetchLocation()) {
      //getStatus(loc.getLatitude(),loc.getLongitude())
    }
    //stop the refresh icon animation
    Timer(Duration(seconds: 1), () => _refreshAnimator.stop());
    return "Safe";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      //padding: EdgeInsets.all(10),
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: myYellow, width: 5),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Embankment Status",
                            style: TextStyle(fontSize: 20, color: myBlack),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),

                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: RotationTransition(
                          turns: Tween(begin: 0.0, end: 10.0)
                              .animate(_refreshAnimator),
                          child: IconButton(
                            icon: Icon(Icons.refresh),
                            color: myBlue,
                            onPressed: () {
                              _refreshAnimator.repeat();
                              //get embankment status from server
                              _getEmbankmentStatus();
                            },
                          ),
                        ),
                      ),
                    )

                    // RaisedButton(
                    //     child: Text("Stop"),
                    //     onPressed: () {
                    //       _refreshAnimator.stop();
                    //     })
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: myYellow, width: 5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Safe",
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: myBlack),
                    ),
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
