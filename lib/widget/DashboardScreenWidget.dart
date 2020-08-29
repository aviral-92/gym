import '../model/AdtTest.dart';
import '../services/RestApiService.dart';
import 'package:flutter/material.dart';
import '../Screens/BookingScreen.dart';
import '../constants/Constants.dart';
import '../model/AdtItems.dart';
import '../providers/AdtItemsList.dart';

class DashboardScreenWidget extends StatelessWidget {
  final Future<AdtItemsList> adtItemsListFuture;
  DashboardScreenWidget(this.adtItemsListFuture);

  Future<Image> downloadImage(String id) async {
    var response = await getFutureImage(id);
    return Image.memory(
      response,
      fit: BoxFit.fitWidth,
      height: 120,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdtItemsList>(
      future: adtItemsListFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Constants.loadingView();
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                if (snapshot.data.adtItemsList != null) {
                  if (snapshot.data.adtItemsList.length > 0) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.adtItemsList.length,
                      itemBuilder: (context, index) {
                        return getWidget(
                            snapshot.data.adtItemsList[index], context);
                      },
                    );
                  }
                }
              }
              return Constants.noDataView("No data found");
            }
          case ConnectionState.none:
            break;
        }
        return Constants.noDataView("No data found");
      },
    );
  }

  bool _args;
  Future<void> loggedInState() async {
    final response = await getLoggedInState();
    //print(response);
    _args = response;
  }

  Widget getWidget(AdtItems adtItems, BuildContext context) {
    //bool args = ModalRoute.of(context).settings.arguments;
    //bool args;
    loggedInState();
    //print('Args====>$_args');
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingScreen(
            adtTest: AdtTest(adtItems, _args),
          ),
        ),
      ),
      child: Card(
        elevation: 6,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Constants.APP_BAR_COLOR,
                Colors.white,
                Colors.deepPurple
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  /* Image Widget*/
                  child: prepareWidget(adtItems),
                ),
              ),
              Spacer(),
              Text(
                '${adtItems.itemName}',
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
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget prepareWidget(AdtItems adtItems) {
    return FutureBuilder<Image>(
      future: downloadImage(adtItems.awsId),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Constants.loadingView();
          case ConnectionState.active:
            break;
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return snapshot.data;
                      //setBoxValue(adtItems, snapshot.data);
                    },
                  );
                }
              }
              return Constants.noDataView("No data found");
            }
          case ConnectionState.none:
            break;
        }
        return Constants.noDataView("No data found");
      },
    );
  }
}
