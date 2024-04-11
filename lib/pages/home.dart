import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_page/pages/quizpage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<String> images = [
    "assets/images/py.png",
    "assets/images/java.png",
    "assets/images/js.png",
    "assets/images/cpp.png",
    "assets/images/linux.png",
  ];

  List<String> subjects = [
    "cpp",
    "java",
    "linux",
    "python",
  ];

  Widget customCard(String subject, String image) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            _showDifficultyDialog(context, subject);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(image),
                ),
              ),
              Text(
                subject,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDifficultyDialog(BuildContext context, String subject) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Difficulty'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('easy');
                },
                child: Text('Easy'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('medium');
                },
                child: Text('Medium'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop('hard');
                },
                child: Text('Hard'),
              ),
            ],
          ),
        );
      },
    ).then((difficulty) {
      if (difficulty != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => GetJson(subject, difficulty),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffb4cdfa), Color(0xf49682de)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 220,
                    padding: EdgeInsets.only(left: 20.0, top: 50.0),
                    decoration: BoxDecoration(
                      color: Color(0xff78258B),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset('assets/images/robot.png', height: 50, width: 50, fit: BoxFit.cover,)),
                        SizedBox(
                          width: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Color(0xff78258B)),
                    margin: EdgeInsets.only(top: 120.0, left: 20.0, right: 20.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset("assets/images/img.png", width: 350,))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 30.0,),
              Text("Top Quiz Categories", style: TextStyle(color: Colors.black, fontSize: 23.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 30.0,),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                padding: EdgeInsets.all(20),
                children: [
                  customCard("cpp", images[3]),
                  customCard("java", images[1]),
                  customCard("javaScript", images[2]),
                  customCard("python", images[0]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
