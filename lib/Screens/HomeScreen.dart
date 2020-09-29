import 'package:flutter/material.dart';
//import '../constants/Constants.dart';
//import '../widget/HomeScreenWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateSignup(BuildContext context) {
    Navigator.of(context).pushNamed('/signup-screen');
  }

  void navigateLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/login-screen');
  }

  Color gradientStart =
      Colors.deepPurple[700]; //Change start gradient color here
  Color gradientEnd = Colors.purple[500];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        /* appBar: new AppBar(
          backgroundColor: Constants.APP_BAR_COLOR,
          //title: new Text('Gradient Decoration'),
        ),*/
        body: new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: const FractionalOffset(0.5, 0.0),
                end: const FractionalOffset(0.0, 0.5),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                //width: double.infinity,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  './assets/img/logo.jpeg',
                  fit: BoxFit.fill,
                  //height: 550,
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 100,
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'to',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'The Fitness Place',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.yellow),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              ButtonTheme(
                minWidth: 350.0,
                height: 75.0,
                child: RaisedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/login-signup-screen'),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21.0),
                      side: BorderSide(color: Colors.red)),
                  color: gradientStart,
                  elevation: 9,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Stay active and stay fit.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 25,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
