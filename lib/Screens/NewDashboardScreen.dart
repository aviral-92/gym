import 'package:Gym/constants/Constants.dart';
import 'package:Gym/providers/AdtItemsList.dart';
import 'package:Gym/services/RestApiService.dart';
import 'package:Gym/widget/DashboardScreenWidget.dart';
import 'package:Gym/widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class NewDashboardScreen extends StatefulWidget {
  @override
  _NewDashboardScreenState createState() => _NewDashboardScreenState();
}

class _NewDashboardScreenState extends State<NewDashboardScreen> {
  Future<AdtItemsList> adtItemsListFuture;

  @override
  void initState() {
    setState(() {
      adtItemsListFuture = getAdtItemsData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(true),
      body: DashboardScreenWidget(adtItemsListFuture),
    );
  }

  Widget getWidget() => Card(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Constants.APP_BAR_COLOR,
                Colors.white,
                //Colors.white70,
                Colors.deepPurple
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  './assets/img/IMG_1632.jpeg',
                  height: 150,
                  // width: 80,
                ),
                //flex: 2,
              ),
              //SizedBox(width: 10),
              Spacer(),
              Text(
                'Exercise',
                style: TextStyle(
                  fontSize: Constants.FONT_SIZE,
                  fontWeight: Constants.FONT_WEIGHT,
                  color: Colors.black,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_right,
                size: 50.0,
              ),
            ],
          ),
        ),
      );
}
