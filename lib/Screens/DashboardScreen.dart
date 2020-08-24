import 'package:flutter/material.dart';
import '../widget/DashboardScreenWidget.dart';
import '../services/RestApiService.dart';
import '../providers/AdtItemsList.dart';
import '../constants/Constants.dart';
import '../widget/MainDrawer.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
    bool args = ModalRoute.of(context).settings.arguments;
    //print(args);
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Dashboard - choose to select'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: DashboardScreenWidget(adtItemsListFuture),
    );
  }
}
