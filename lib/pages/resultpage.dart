import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class ResultPage extends StatefulWidget {
  final int marks;

  ResultPage({required Key key, required this.marks}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    "assets/images/success.png",
    "assets/images/good.png",
    "assets/images/bad.png",
  ];

  late String message;
  late String image;

  @override
  void initState() {
    if (widget.marks < 20) {
      image = images[2];
      message = "You Should Try Hard..\n" + "You Scored ${widget.marks}";
    } else if (widget.marks < 35) {
      image = images[1];
      message = "You Can Do Better..\n" + "You Scored ${widget.marks}";
    } else {
      image = images[0];
      message = "You Did Very Well..\n" + "You Scored ${widget.marks}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Your result",
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
      ),
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffb4cdfa), Color(0xf49682de)],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Material(
                color: Color(0xf49682de), // Set Material's color to transparent
                elevation: 10.0,
                child: Container(
                  // Set Container's color to transparent
                  child: Column(
                    children: <Widget>[
                      Material(
                        child: Container(
                          color: Color(0xf49682de),
                          width: 350.0,
                          height: 350.0,
                          child: ClipRect(
                            child: Image(
                              image: AssetImage(image),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            message,
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Quando",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            Homepage(), // Adjust the widget name accordingly
                      ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xff78258B),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
