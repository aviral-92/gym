import 'package:flutter/material.dart';
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
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: snapshot.data.adtItemsList.length,
                      itemBuilder: (context, index) {
                        return dashBoardScreenWidget(
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
    return Container(
      child: Card(
        child: GestureDetector(
          onTap: () => {
            Navigator.of(context).pushNamed('/booking-screen', arguments: true)
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
}
