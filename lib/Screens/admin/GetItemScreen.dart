import 'package:Gym/widget/GetItemScreenWidget.dart';
import 'package:flutter/material.dart';
import '../../constants/Constants.dart';
import '../../widget/MainDrawer.dart';

class GetItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    print(args);
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text('Get Item Schedule'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: GetItemScreenWidget(),
    );
  }
}
