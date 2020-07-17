import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jal_shakti_sush/classes/localization/localization.dart';
import 'package:jal_shakti_sush/screens/jal_shakti_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn');
  print("Status:$status");
  runApp(MyApp(status));
}

// void main() {
//   runApp(DevicePreview(
//     enabled: !kReleaseMode,
//     usePreferences: false,
//     builder: (context) => MyApp(),
//   ));
// }

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    state.setState(() {
      state.locale = newLocale;
    });
  }

  bool status = false;
  MyApp(this.status);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  bool localeLoaded = false;
  SharedPreferences prefs;
  bool isLoggedIn = false;
  @override
  void initState() {
    this._fetchLocale().then((locale) {
      setState(() {
        this.localeLoaded = true;
        this.locale = locale;
      });
    });
    super.initState();
  }

  // Future<bool> checkIfLoggedIn() async {
  //   prefs = await SharedPreferences.getInstance();
  //   var loggedIn = prefs.getBool('isLoggedIn');
  //   if (loggedIn == true)
  //     return true;
  //   else
  //     return false;
  // }

  @override
  Widget build(BuildContext context) {
    // if (checkIfLoggedIn()) {
    //   setState(() {
    //     isLoggedIn = true;
    //   });
    // }
    return MaterialApp(
      title: 'Jal SHakti',
      theme: ThemeData(
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[50]
              : null),
      //builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('hi', ''), // Hindi
      ],
      locale: locale,
      home: SafeArea(
        child: Stack(
          children: <Widget>[
            widget.status ? JalShaktiHome(user: 'admin') : JalShaktiHome()
          ],
        ),
      ),
    );
  }

  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.getString('languageCode') == null) {
      return null;
    }

    print('_fetchLocale():' +
        (prefs.getString('languageCode') +
            ':' +
            prefs.getString('countryCode')));

    return Locale(
        prefs.getString('languageCode'), prefs.getString('countryCode'));
  }
} //_MyAppState
