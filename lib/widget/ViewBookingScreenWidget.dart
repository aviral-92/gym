import 'dart:convert';

import 'package:Gym/model/AdtUsers.dart';
import 'package:Gym/providers/AdtUsersList.dart';
import 'package:Gym/services/RestApiService.dart';

import '../constants/Constants.dart';
import '../model/AdtItemSlots.dart';
import '../providers/AdtItemSlotsList.dart';
import 'package:flutter/material.dart';

class ViewBookingScreenWidget extends StatefulWidget {
  final Future<AdtItemSlotsList> adtItemSlotFuture;
  ViewBookingScreenWidget(this.adtItemSlotFuture);

  @override
  _ViewBookingScreenWidgetState createState() =>
      _ViewBookingScreenWidgetState();
}

class _ViewBookingScreenWidgetState extends State<ViewBookingScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdtItemSlotsList>(
        future: widget.adtItemSlotFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Constants.loadingView();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  if (snapshot.data.adtItemSlotList != null) {
                    if (snapshot.data.adtItemSlotList.length > 0) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: snapshot.data.adtItemSlotList.length,
                          itemBuilder: (context, index) {
                            return generateColumn(
                                snapshot.data.adtItemSlotList[index], context);
                          });
                    } else {
                      return Constants.noDataView("No data found");
                    }
                  } else {
                    // display error message if your list or data is null.
                    //return noDataView("No data found");
                  }
                } else if (snapshot.hasError) {
                  // display your message if snapshot has error.
                  //print('2');
                  return Constants.noDataView("No booking schedule found.");
                } else {
                  print(snapshot.data);
                  return Constants.noDataView("Something went wrong");
                }
                return Constants.noDataView("No data found");
              }
            case ConnectionState.none:
              break;
          }
          return Constants.noDataView("No data found");
        });
  }

  Widget generateColumn(AdtItemSlots adtItemSlots, BuildContext context) {
    return getColumnWidget(
        Constants.splitAndConvertStringToTime(adtItemSlots.startHour),
        Constants.splitAndConvertStringToTime(adtItemSlots.endHour),
        adtItemSlots.desc,
        adtItemSlots,
        context);
  }

  Widget getColumnWidget(DateTime startTime, DateTime endTime, String desc,
      AdtItemSlots adtItemSlots, BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('$desc'),
            Text(
              '${Constants.timeFormat.format(startTime)} - ${Constants.timeFormat.format(endTime)}',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
            Text('${adtItemSlots.itemCount}'),
            GestureDetector(
              child: Text('View'),
              onTap: () {
                //Constants.showDialogue(context, 'value');
                test(context, '${adtItemSlots.id}');
              },
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Future<AdtUsersList> adtUsersListFuture;

  void test(BuildContext context, String slotId) {
    //print('SlotID===> $slotId');
    var response = getUserData(slotId);
    if (response != null) {
      setState(() {
        adtUsersListFuture = response;
        //print('set state ends');
      });
      adtUsersListFuture.then((value) => print('VALUE ==> $value'));
      //print('adtUsersListFuture===>$adtUsersListFuture');
      var getWidget = futureBuild(adtUsersListFuture);
      //print('Checking');
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text('Users List'),
              content: getWidget,
            );
          });
    }
  }

  Future<AdtUsersList> getUserData(String slotId) async {
    var response = await getBookedSlotsOfSlotId(slotId);
    var message = json.decode(response.body);
    if (message.toString().contains('message')) {
      return null;
    }
    return AdtUsersList.fromJson(json.decode(response.body));
    //json.decode(response.body);
  }

  Widget futureBuild(Future<AdtUsersList> adtUserListFuture) {
    print('Called');
    return FutureBuilder<AdtUsersList>(
        future: adtUserListFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Constants.loadingView();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              {
                if (snapshot.hasData) {
                  if (snapshot.data.adtUsersList != null) {
                    if (snapshot.data.adtUsersList.length > 0) {
                      return Container(
                        height: 500,
                        width: 600,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: snapshot.data.adtUsersList.length,
                            itemBuilder: (context, index) {
                              return generateNewColumn(
                                  snapshot.data.adtUsersList[index]);
                            }),
                      );
                    } else {
                      return Constants.noDataView("No data found");
                    }
                  } else {
                    // display error message if your list or data is null.
                    //return noDataView("No data found");
                  }
                } else if (snapshot.hasError) {
                  // display your message if snapshot has error.
                  //print('2');
                  return Constants.noDataView("No booking schedule found.");
                } else {
                  print(snapshot.data);
                  return Constants.noDataView("No user exist");
                }
                return Constants.noDataView("No data found");
              }
            case ConnectionState.none:
              break;
          }
          return Constants.noDataView("No data found");
        });
  }

  Widget generateNewColumn(AdtUsers adtUsers) {
    print('ID=====> ${adtUsers.id}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${adtUsers.id}'),
        Text('  '),
        Text('${adtUsers.name}'),
        Text('  '),
        Text('${adtUsers.userName}'),
        Text('  '),
        Text('${adtUsers.mobile}'),
      ],
    );
  }
}
