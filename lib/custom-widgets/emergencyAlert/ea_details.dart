import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:jal_shakti_sush/classes/Constants.dart';

//Advisory Class
class EAContent extends StatefulWidget {
  final getRegionData;
  EAContent(this.getRegionData);
  @override
  _EAContentState createState() => _EAContentState();
}

class _EAContentState extends State<EAContent> {
  TextEditingController msgController = TextEditingController();
  bool isVisible = false;
  SnackBar snackBar;

  var data = [
    {
      "id": 1,
      "title": "Debris Removal",
      "boolValue": false,
    },
    {
      "id": 2,
      "title": "Crack Repairs",
      "boolValue": false,
    },
    {
      "id": 3,
      "title": "Vegetation removal",
      "boolValue": false,
    },
    {
      "id": 4,
      "title": "Overall maintenance",
      "boolValue": false,
    },
  ];

  getFilteredData() {
    var filteredData = [];
    for (var item in data) {
      if (item['boolValue']) filteredData.add(item);
    }

    return filteredData;
  }

  Future<bool> sendAdvisoryReportToServer(var data) async {
    var prefs = await SharedPreferences.getInstance();
    String user = prefs.getString("user");
    var place = widget.getRegionData();
    var dataToSend = {
      "state": place['state'],
      "district": place['district'],
      "region": place['region'],
      "reporter": user,
      "report-type": "advisory",
      "data": data
    };
    print("Sending data to server...\n$dataToSend");
    bool flag = false;
    String message;
    try {
      var response = await http.post(SERVER_URL + '/api/emergency',
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(dataToSend));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        flag = jsonResponse['status'] == 1 ? true : false;
        message = jsonResponse['message'];
      } else {
        message = "Some error occured...";
      }
    } on TimeoutException catch (timeoutError) {
      message = "Connection timed out...";
    } on SocketException catch (socketException) {
      message = "Some error occured...Please try again";
    } on Error catch (err) {
      message = "Some error occured...Please try again";
    }
    snackBar = SnackBar(
      content: Text(message),
    );
    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                        "Below mentioned are some of the most relevant categories of embankment advisory conditions.\nPlease select most appropriate ones.These may or may not be addressed by authorities involved."),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        ...data.map((category) => categoryCheckBox(
                            category['id'],
                            category['title'],
                            category['boolValue']))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: messageBox(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: isVisible
                          ? CircularProgressIndicator(
                              backgroundColor: myYellow,
                            )
                          : RaisedButton(
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: myBlue,
                              onPressed: () async {
                                setState(() {
                                  isVisible = true;
                                });
                                var sent = await sendAdvisoryReportToServer(
                                    await getFilteredData());
                                setState(() {
                                  isVisible = false;
                                });
                                if (sent) {
                                  //success
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  Timer(Duration(milliseconds: 2000),
                                      () => Navigator.pop(context));
                                } else {
                                  //error
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                              },
                            ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget categoryCheckBox(int id, String title, bool boolValue) {
    return Column(
      children: <Widget>[
        //checkbox row
        Row(
          children: <Widget>[
            Checkbox(
              value: boolValue,
              onChanged: (value) {
                print("Value:$value");
                setState(() {
                  //print(data[id - 1]);
                  data[id - 1]['boolValue'] = value;
                  print(data[id - 1]);
                });
              },
            ),
            Text(title),
          ],
        ),
      ],
    );
  }

  Widget messageBox() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: myBlue,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: msgController,
        maxLines: 10,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Write some more message if any...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
