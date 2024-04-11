import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page/pages/resultpage.dart';

class GetJson extends StatefulWidget {
  final String subject;
  final String difficulty;

  GetJson(this.subject, this.difficulty);

  @override
  _GetJsonState createState() => _GetJsonState();
}

class _GetJsonState extends State<GetJson> {
  late String assetToLoad;

  void setAsset() {
    String difficultyPrefix = '';

    // Generate the asset path based on subject and difficulty level
    assetToLoad = "assets/${widget.subject}_${widget.difficulty}.json";
  }

  @override
  Widget build(BuildContext context) {
    setAsset();

    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context).loadString(assetToLoad),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Scaffold(
            body: Center(
              child: Text("Error loading data geksdjke "),
            ),
          );
        } else {
          List myData = json.decode(snapshot.data!);
          return QuizPage(subject: widget.subject, difficulty: widget.difficulty, myData: myData, key: UniqueKey());
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  final String subject;
  final String difficulty;
  final List myData;

  QuizPage({ required Key key,required this.myData, required this.subject, required this.difficulty}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}




class _QuizPageState extends State<QuizPage> {
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int currentQuestionIndex = 0;
  int timer = 30;
  String showTimer = "30";
  var randomArray = [];

  Map<String, Color> btnColor = {
    "a": Color(0xf49682de),
    "b": Color(0xf49682de),
    "c": Color(0xf49682de),
    "d": Color(0xf49682de),
  };

  bool cancelTimer = false;

  @override
  void initState() {
    super.initState();
    genRandomArray();
    startTimer();
  }

  void genRandomArray() {
    var rand = Random();
    while (randomArray.length < 10) {
      int randomNumber = rand.nextInt(widget.myData[1].length) + 1;
      if (!randomArray.contains(randomNumber)) {
        randomArray.add(randomNumber);
      }
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer) {
          t.cancel();
        } else {
          timer -= 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    setState(() {
      if (currentQuestionIndex < 9) {
        currentQuestionIndex++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultPage(marks: marks, key: UniqueKey()),
        ));
      }
      btnColor.forEach((key, value) {
        btnColor[key] = Color(0xf49682de);
      });
    });
    startTimer();
  }

  void checkAnswer(String k) {
    String correctAnswer = widget.myData[2][randomArray[currentQuestionIndex].toString()];
    String selectedAnswerIndex = k;

    if (selectedAnswerIndex == correctAnswer) {
      marks += 5;
      btnColor[k] = right;
    } else {
      btnColor[k] = wrong;
      
    }

    setState(() {
      cancelTimer = true;
    });

    Timer(Duration(seconds: 2), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        child: Text(
          widget.myData[1][randomArray[currentQuestionIndex].toString()][k],
          style: TextStyle(
            color: Colors.white,

            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btnColor[k],
        splashColor: Color(0xf49682de),
        highlightColor: Color(0xff78258B),
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Quizizz"),
            content: Text("You can't go back at this stage."),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/images/robot.png',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "It's Quiz Time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Color(0xf49682de), // Set to transparent
          elevation: 0, // Remove elevation
        ),
        body: Container(
          height: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xf49682de), Color(0xffb33bbe)],
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                height: 280,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xff78258B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          widget.myData[0][randomArray[currentQuestionIndex].toString()],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: "Quando",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,

                child: AbsorbPointer(
                  absorbing: cancelTimer,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        choiceButton('a'),
                        choiceButton('b'),
                        choiceButton('c'),
                        choiceButton('d'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,

                child: Container(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Text(
                      showTimer,
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
