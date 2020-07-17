class QuestionAnswer {
  static final questionanswer = [
    {
      "id": 1,
      "question": "Is there any crack?",
      "imgurl": "assets/images/crack.jpg",
      "answers": ["Yes1", "No1"],
    },
    {
      "id": 2,
      "question": "Does the embankment has seepage?",
      "imgurl": "assets/images/crack.jpg",
      "answers": ["Yes1", "No1", "Yes2", "No2"]
    },
    {
      "id": 3,
      "question": "Is there any animal burrows?",
      "imgurl": "assets/images/crack.jpg",
      "answers": ["ya", "na"]
    },
    {
      "id": 4,
      "question": "Is there any misalingmnet?",
      "imgurl": "assets/images/crack.jpg",
      "answers": ["Ho", "Nhi", "Nhi mahit"]
    },
    {
      "id": 5,
      "question": "Does the water level is increased?",
      "imgurl": "assets/images/crack.jpg",
      "answers": ["yes", "no"]
    }
  ];

  static var surveyData = {
    "surveyer": "ABC XYZ",
    "time-stamp": "Thu 16 July 2020 11:26",
    "state": "Maharashtra",
    "district": "Pune",
    "image-url": "<host-url>/uploads/surveyImages/imageName.png",
    "location": {"latitude": "18.234567", "longitude": "73.345786"},
    "survey-data": [
      {
        "category": "1", //general questions
        "items": {
          //string answers
          "type1": {
            "Q1": "Answer1",
            "Q2": "Answer2",
            "Q3": "Answer3",
          },
          //yes-no answers
          "type2": {
            "Q1": "Yes",
            "Q2": "No",
            "Q3": "Yes",
          },
        },
      },
      {
        "category": "2", //health-card questions
        "items": {
          //string answers
          "type1": {
            "Q1": "Answer1",
            "Q2": "Answer2",
            "Q3": "Answer3",
          },
          //yes-no answers
          "type2": {
            "Q1": "Yes",
            "Q2": "No",
            "Q3": "Yes",
          },
          //slider-answers
          "type3": {
            "Q1": 4.5,
            "Q2": 9,
            "Q3": 5.6,
          },
        },
      },
    ]
  };
}
