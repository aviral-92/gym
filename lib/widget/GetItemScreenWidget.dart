import 'package:Gym/constants/Routing.dart';
import 'package:Gym/model/AdtTest.dart';
import 'package:flutter/material.dart';
import '../Screens/BookingScreen.dart';
import '../constants/Constants.dart';
import '../services/RestApiService.dart';
import '../model/AdtItems.dart';
import '../providers/AdtItemsList.dart';

class GetItemScreenWidget extends StatefulWidget {
  @override
  _GetItemScreenWidgetState createState() => _GetItemScreenWidgetState();
}

class _GetItemScreenWidgetState extends State<GetItemScreenWidget> {
  Future<AdtItemsList> adtItemsListFuture;
  TextEditingController _c;

  @override
  void initState() {
    setState(() {
      adtItemsListFuture = getAdtItemsData();
      _c = new TextEditingController();
    });
    super.initState();
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
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.adtItemsList.length,
                      itemBuilder: (context, index) {
                        return getItemWidget(
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

  Widget getItemWidget(AdtItems adtItems, BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    Routing route = new Routing(args);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  adtItems.itemName,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                width: 150,
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    showDialog(
                        child: new Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: new Column(
                            children: <Widget>[
                              new TextField(
                                decoration: new InputDecoration(
                                    hintText: "Update Info"),
                                controller: _c,
                              ),
                              new FlatButton(
                                child: new Text("Save"),
                                onPressed: () {
                                  var response = updateItem(new AdtItems(
                                      adtItems.id,
                                      _c.text,
                                      adtItems.itemType,
                                      adtItems.awsId));
                                  response.then((value) => {
                                        if (value.statusCode == 200)
                                          {
                                            print('Success'),
                                          }
                                        else
                                          {
                                            print('Unable to update'),
                                          }
                                      });
                                  Navigator.pop(context);
                                  route
                                      .navigateDeleteOrUpdateItemEvent(context);
                                },
                              )
                            ],
                          ),
                        ),
                        context: context);
                  },
                  child: Text('Update',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16, //0xFFC62828
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  var response =
                      Constants.asyncInputDialog(context, 'Are you sure?');
                  response.then(
                    (value) => {
                      if (value)
                        {
                          deleteItem(adtItems.id).then((value) => {
                                if (value.statusCode == 200)
                                  {
                                    route.navigateDeleteOrUpdateItemEvent(
                                        context),
                                  }
                              }),
                        }
                      else
                        {
                          print('..GetItemScreenWidget() not deleted.'),
                        }
                    },
                  );
                },
                child: Text('Delete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 16, //0xFFC62828
                    )),
              ),
            ],
          ),
          Divider(),
        ],
      ),
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
}
