import 'package:flutter/material.dart';
import 'package:jal_shakti_sush/classes/Constants.dart';
import 'package:jal_shakti_sush/custom-widgets/admin_login/admin_login_modal.dart';
import 'package:jal_shakti_sush/custom-widgets/embankment_status_card.dart';
import 'package:jal_shakti_sush/custom-widgets/permission_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_container/overlay_container.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:jal_shakti_sush/classes/localization/localization.dart';
import 'package:jal_shakti_sush/main.dart';
import 'package:jal_shakti_sush/classes/Model/radio_model.dart';
import 'package:jal_shakti_sush/custom-widgets/admin_drawer.dart';
import 'package:jal_shakti_sush/screens/more_info.dart';
import '../custom-widgets/introduction_card.dart';
import './survey_page.dart';

class JalShaktiHome extends StatefulWidget {
  final String user;
  JalShaktiHome({this.user});
  @override
  _JalShaktiHomeState createState() => _JalShaktiHomeState(user);
}

class _JalShaktiHomeState extends State<JalShaktiHome> {
  //required for localization
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<RadioModel> _langList = new List<RadioModel>();
  int _index = 0;
  bool languageMenuShown = false;
  ///////////////////////////
  final String user;
  var permissions = false;
  String locale = 'en';

  _JalShaktiHomeState(this.user);

  @override
  void initState() {
    super.initState();
    _updateLocale(locale, '');
    //_getLangList();
    getPermissions();
  }

  getPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();
    if (statuses[Permission.camera].isGranted &&
        statuses[Permission.location].isGranted) {
      setState(() {
        permissions = true;
      });
    } else {
      setState(() {
        permissions = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          print("Clicked outside overlay container");
          if (languageMenuShown) {
            setState(() {
              languageMenuShown = !languageMenuShown;
            });
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          drawer: user == "admin" ? AdminDrawer() : null,
          // appBar: AppBar(
          //   title: Text(AppLocalizations.of(context).appName),
          //   actions: <Widget>[
          //     IconButton(
          //         icon: Icon(Icons.translate),
          //         onPressed: () {
          //           //change lauguage
          //           setState(() {
          //             languageMenuShown = !languageMenuShown;
          //           });
          //         }),
          //     IconButton(
          //         icon: Icon(Icons.help_outline),
          //         onPressed: () {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) {
          //             return MoreInfo();
          //           }));
          //         }),
          //   ],
          // ),
          body: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff14235e),
                      Color(0xffc68ebd),
                      Color(0xffffd3be)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        //home app bar
                        _homeAppBar(context),
                        //_buildLanguageWidget(),
                        Center(
                          child: IntroductionCard(),
                        ),
                        !permissions
                            ? PermissionRequestCard(getPermissions)
                            : Visibility(
                                child: Text(""),
                                visible: false,
                              ),
                        EmbankmentStatusCard(),
                        RaisedButton(
                          child: Text(AppLocalizations.of(context).startSurvey),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Surveypage("no-image");
                            }));
                          },
                        ),
                      ],
                    ),
                    user == "admin" ? Container() : AdminLoginModal(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeAppBar(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: user == "admin"
                  ? IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    )
                  : Container(),
            ),
            Expanded(
              flex: 7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).appName,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: Icon(
                  Icons.translate,
                  color: Colors.white,
                ),
                onPressed: () {
                  //change lauguage
                  setState(() {
                    locale == 'en' ? locale = 'hi' : locale = 'en';
                    _updateLocale(locale, '');
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                icon: Icon(
                  Icons.help_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MoreInfo();
                  }));
                },
              ),
            ),
          ],
        ));
  }

  void _updateLocale(String lang, String country) async {
    print(lang + ':' + country);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', lang);
    prefs.setString('countryCode', country);

    MyApp.setLocale(context, Locale(lang, country));
  }
}
// Widget _buildLanguageWidget() {
//   return OverlayContainer(
//     show: languageMenuShown,
//     position: OverlayContainerPosition(240, 10),
//     child: Container(
//       height: 120,
//       width: 100,
//       padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
//       margin: EdgeInsets.only(left: 4.0, right: 4.0),
//       color: Colors.grey[100],
//       child: ListView.builder(
//         itemCount: _langList.length,
//         scrollDirection: Axis.vertical,
//         itemBuilder: (BuildContext context, int index) {
//           return new InkWell(
//             splashColor: Colors.blueAccent,
//             onTap: () {
//               setState(() {
//                 _langList.forEach((element) => element.isSelected = false);
//                 _langList[index].isSelected = true;
//                 _index = index;
//                 _handleRadioValueChanged();
//               });
//             },
//             child: RadioItem(_langList[index]),
//           );
//         },
//       ),
//     ),
//   );
// }

// ///required for localization
// List<RadioModel> _getLangList() {
//   if (_index == 0) {
//     _langList.add(new RadioModel(true, 'English'));
//     _langList.add(new RadioModel(false, 'हिंदी'));
//   } else if (_index == 1) {
//     _langList.add(new RadioModel(false, 'English'));
//     _langList.add(new RadioModel(true, 'हिंदी'));
//   }

//   return _langList;
// }

// Future<String> _getLanguageCode() async {
//   var prefs = await SharedPreferences.getInstance();
//   if (prefs.getString('languageCode') == null) {
//     return null;
//   }
//   print('_fetchLocale():' + prefs.getString('languageCode'));
//   return prefs.getString('languageCode');
// }

// void _initLanguage() async {
//   Future<String> status = _getLanguageCode();
//   status.then((result) {
//     if (result != null && result.compareTo('en') == 0) {
//       setState(() {
//         _index = 0;
//       });
//     }
//     if (result != null && result.compareTo('hi') == 0) {
//       setState(() {
//         _index = 1;
//       });
//     } else {
//       setState(() {
//         _index = 0;
//       });
//     }
//     print("INDEX: $_index");

//     _setupLangList();
//   });
// }

// void _setupLangList() {
//   setState(() {
//     _langList.add(new RadioModel(_index == 0 ? true : false, 'English'));
//     _langList.add(new RadioModel(_index == 0 ? false : true, 'हिंदी'));
//   });
// }

//   void _handleRadioValueChanged() {
//     print("SELCET_VALUE: " + _index.toString());
//     setState(() {
//       switch (_index) {
//         case 0:
//           print("English");
//           _updateLocale('en', '');
//           break;
//         case 1:
//           print("Hindi");
//           _updateLocale('hi', '');
//           break;
//       }
//       languageMenuShown = !languageMenuShown;
//     });
//   }

//   ////////////////////
// }

// class RadioItem extends StatelessWidget {
//   final RadioModel _item;

//   RadioItem(this._item);

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
//       margin: EdgeInsets.only(left: 4.0, right: 4.0),
//       color: Colors.grey[100],
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.only(left: 4.0, right: 4.0),
//             child: new Column(
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 new Container(
//                   width: 60.0,
//                   height: 4.0,
//                   decoration: new BoxDecoration(
//                     color: _item.isSelected
//                         ? Colors.redAccent
//                         : Colors.transparent,
//                     border: new Border.all(
//                         width: 1.0,
//                         color: _item.isSelected
//                             ? Colors.redAccent
//                             : Colors.transparent),
//                     borderRadius:
//                         const BorderRadius.all(const Radius.circular(2.0)),
//                   ),
//                 ),
//                 new Container(
//                   margin: new EdgeInsets.only(top: 8.0),
//                   child: new Text(
//                     _item.title,
//                     style: TextStyle(
//                       color:
//                           _item.isSelected ? Colors.redAccent : Colors.black54,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
