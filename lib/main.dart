import 'package:flutter/material.dart';

import 'package:jal_shakti_sush/screens/jal_shakti_home.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jal SHakti',
      debugShowCheckedModeBanner: false,
      home: new JalShaktiHome(),
    );
  }
}
