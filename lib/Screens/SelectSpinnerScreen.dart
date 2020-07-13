import '../constants/Constants.dart';
//import '../widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class SelectSpinnerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //bool args = ModalRoute.of(context).settings.arguments;
    //var size = MediaQuery.of(context).size;
    //final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    //final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Select Spinner'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      //drawer: MainDrawer(args),
      body: GridView.count(
        crossAxisCount: 3,
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        //childAspectRatio: (itemWidth / itemHeight),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text("He'd have you all unravel at the"),
            color: Colors.teal[100],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Heed not the rabble'),
            color: Colors.teal[200],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text("He'd have you all unravel at the"),
            color: Colors.teal[100],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Heed not the rabble'),
            color: Colors.teal[200],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text("He'd have you all unravel at the"),
            color: Colors.teal[100],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: const Text('Heed not the rabble'),
            color: Colors.teal[200],
          ),
        ],
      ),
      // ),
    );
  }
}
