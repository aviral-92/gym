import 'package:Gym/model/AdtTest.dart';
import 'package:flutter/material.dart';
import '../Screens/BookingScreen.dart';
import '../constants/Constants.dart';
import '../model/AdtItems.dart';
import '../providers/AdtItemsList.dart';

class DashboardScreenWidget extends StatelessWidget {
  final Future<AdtItemsList> adtItemsListFuture;

  DashboardScreenWidget(this.adtItemsListFuture);

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
                      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //   crossAxisCount: 2),
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

  Widget dashBoardScreenWidget(AdtItems adtItems, BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Card(
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingScreen(
                  adtTest: AdtTest(adtItems, args),
                ),
              ),
            )
          },
          child: Card(
            elevation: 6,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    './assets/img/IMG_1632.jpeg',
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
        ),
      ),
    );
  }

  Widget getWidget(AdtItems adtItems, BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingScreen(
            adtTest: AdtTest(adtItems, args),
          ),
        ),
      ),
      child: Card(
        elevation: 6,
        child: Container(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  './assets/img/IMG_1632.jpeg',
                  height: 150,
                  // width: 80,
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
}
