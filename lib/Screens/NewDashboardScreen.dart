import '.././constants/Constants.dart';
import '.././providers/AdtItemsList.dart';
import '.././services/RestApiService.dart';
import '.././widget/DashboardScreenWidget.dart';
import '.././widget/MainDrawer.dart';
import 'package:flutter/material.dart';

class NewDashboardScreen extends StatefulWidget {
  final bool args;

  const NewDashboardScreen({Key key, this.args}) : super(key: key);
  @override
  _NewDashboardScreenState createState() => _NewDashboardScreenState(args);
}

class _NewDashboardScreenState extends State<NewDashboardScreen> {
  Future<AdtItemsList> adtItemsListFuture;
  bool args;
  _NewDashboardScreenState(this.args);

  @override
  void initState() {
    setState(() {
      adtItemsListFuture = getAdtItemsData();
    });
    setArgs();
    super.initState();
  }

  void setArgs() async {
    var admin;
    await isAdminState().then((value) => admin = value);
    setState(() {
      args = admin;
    });
  }

  @override
  Widget build(BuildContext context) {
    //= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: DashboardScreenWidget(adtItemsListFuture),
    );
  }
}
