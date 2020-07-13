import 'package:flutter/material.dart';
import './question_answer_data.dart';
import './new_card.dart';

class ReceiveQuestionAnswer extends StatefulWidget {
  @override
  _ReceiveQuestionAnswerState createState() => _ReceiveQuestionAnswerState();
}

class _ReceiveQuestionAnswerState extends State<ReceiveQuestionAnswer> {
  final questionanswer = QuestionAnswer.questionanswer;
  Map<String, String> surveyData =
      {}; //contains the questions number and corresponding answer
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < questionanswer.length; i++) {
      surveyData[i.toString()] = '';
    }
  }

  onAnswerChanged(int index, String value) {
    setState(() {
      surveyData[index.toString()] = value;
    });
    print("Survey data:");
    print(surveyData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            height: 550,
            child: ListView.builder(
                itemCount: questionanswer.length,
                itemBuilder: (context, index) {
                  return NewCard(
                    index,
                    onAnswerChanged,
                    questionanswer[index]["question"],
                    questionanswer[index]["imgurl"],
                    questionanswer[index]["answers"],
                  );
                }),
          ),

          //create listview of type2 questions

          //create listview of type3 questions

          //button to submit all data
          Container(
            child: RaisedButton(
                child: Text("Finish"),
                color: Colors.blue[200],
                onPressed: () {
                  //send survey data to server
                }),
          ),
        ],
      ),
    );
  }
}
