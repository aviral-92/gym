import '../model/AdtItems.dart';
import '../services/RestApiService.dart';

import '../providers/AdtItemsList.dart';
import 'package:flutter/material.dart';
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
        title: Text('Dashboard'),
        backgroundColor: Constants.APP_BAR_COLOR,
      ),
      drawer: MainDrawer(args),
      body: Container(
        //height: 250,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        //child: Card(
        child: getWidget(),

        /*GestureDetector(
          onTap: () => {Navigator.of(context).pushNamed('/booking-screen')},
          child: Card(
            //color: Constants.BACKGROUND_COLOR,
            elevation: 6,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    './assets/img/biking.png',
                  ),
                  flex: 2,
                ),
                SizedBox(height: 10),
                Text(
                  'SPINING',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),*/
      ),
    );
  }

  Widget getWidget() {
    return FutureBuilder<AdtItemsList>(
      future: adtItemsListFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loadingView();
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                if (snapshot.data.adtItemsList != null) {
                  if (snapshot.data.adtItemsList.length > 0) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.adtItemsList.length,
                      itemBuilder: (context, index) {
                        return generateColumn(
                            snapshot.data.adtItemsList[index]);
                      },
                    );
                  }
                }
              }
              return noDataView("No data found");
            }
          case ConnectionState.none:
            break;
        }
        return noDataView("No data found");
      },
    );
  }

  Widget generateColumn(AdtItems adtItems) => dashBoardScreenWidget(adtItems);

  Widget loadingView() => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      );

  Widget dashBoardScreenWidget(AdtItems adtItems) {
    return GestureDetector(
      onTap: () => {Navigator.of(context).pushNamed('/booking-screen')},
      child: Card(
        //color: Constants.BACKGROUND_COLOR,
        elevation: 6,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                './assets/img/biking.png',
              ),
              flex: 2,
            ),
            SizedBox(height: 10),
            Text(
              '${adtItems.itemName}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget noDataView(String msg) => Center(
        child: Text(
          msg,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      );
}
