import 'package:flutter/material.dart';

class IntroductionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Text('What is this about?\n We intend to collect data regarding river embankments.'),
    );
  }
}
