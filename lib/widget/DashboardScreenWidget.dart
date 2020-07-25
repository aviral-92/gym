import 'package:Gym/model/AdtItems.dart';
import 'package:Gym/providers/AdtItemsList.dart';
import 'package:flutter/material.dart';

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
            return loadingView();
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
              return noDataView("No data found");
            }
          case ConnectionState.none:
            break;
        }
        return noDataView("No data found");
      },
    );
  }

  Widget dashBoardScreenWidget(AdtItems adtItems, BuildContext context) {
    return Container(
      child: Card(
        child: GestureDetector(
          onTap: () => {Navigator.of(context).pushNamed('/booking-screen')},
          child: Card(
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
        ),
      ),
    );
  }

  Widget loadingView() => Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
      );

  Widget noDataView(String msg) => Center(
        child: Text(
          msg,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      );
}
