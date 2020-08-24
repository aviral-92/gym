import 'dart:convert';

import 'package:Gym/providers/AdtItemSlotsList.dart';

import '../../services/RestApiService.dart';
import '../../widget/ViewBookingScreenWidget.dart';
import '../../model/AdtItems.dart';
import '../../widget/MainDrawer.dart';
import 'package:horizontal_calendar/horizontal_calendar.dart';
import '../../constants/Constants.dart';
import 'package:flutter/material.dart';

class ViewBookingScreen extends StatefulWidget {
  @override
  _ViewBookingScreenState createState() => _ViewBookingScreenState();
}

class _ViewBookingScreenState extends State<ViewBookingScreen> {
  List<DropdownMenuItem<AdtItems>> _dropdownMenuItems;
  String selectedDate =
      Constants.convertDateToString(Constants.dateFormat, DateTime.now());
  AdtItems adtSelectedItem;
  List<AdtItems> list;
  bool _isVisible = false;
  Future<AdtItemSlotsList> adtItemSlotListFuture;

  @override
  void initState() {
    super.initState();
    _asyncCall();
  }

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Future _asyncCall() async {
    var response = getAdtItemsData();
    List<AdtItems> adtItemList;
    await response.then((value) => adtItemList = value.adtItemsList);
    setState(() {
      list = adtItemList;
    });
    await buildDropDownItems(list).then((value) => _dropdownMenuItems = value);
  }

  @override
  Widget build(BuildContext context) {
    bool args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Constants.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: Constants.APP_BAR_COLOR,
        title: Text('View Booking Schedule'),
      ),
      drawer: MainDrawer(
        admin: args,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HorizontalCalendar(
              initialDate: DateTime.now(),
              date: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 30)),
              textColor: Colors.black,
              backgroundColor: Constants.BACKGROUND_COLOR,
              selectedColor: Constants.APP_BAR_COLOR,
              onDateSelected: (date) => {
                setState(() {
                  selectedDate = date;
                  //setAdtItemSlotListFuture(date);
                })
              },
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: DropdownButtonFormField<AdtItems>(
                value: adtSelectedItem,
                icon: Icon(Icons.arrow_downward),
                items: _dropdownMenuItems,
                onChanged: (value) {
                  setState(() {
                    adtSelectedItem = value;
                  });
                },
              ),
            ),
            Divider(),
            RaisedButton(
              child: Text(
                'Submit',
                style: TextStyle(
                    fontWeight: Constants.FONT_WEIGHT,
                    fontSize: Constants.BUTTON_SIZE,
                    color: Constants.BUTTON_TEXT_COLOR),
              ),
              color: Constants.APP_BAR_COLOR,
              elevation: 6,
              onPressed: () {
                showToast();
              },
            ),
            Visibility(
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              visible: _isVisible,
              child: getSecondView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSecondView() {
    setState(() {
      adtItemSlotListFuture = _getData();
    });
    return ViewBookingScreenWidget(adtItemSlotListFuture);
  }

  Future<AdtItemSlotsList> _getData() async {
    var response = await getSlotsBySlotDateAndAdtItemForAdmin(
        '${adtSelectedItem.id}', selectedDate);
    return AdtItemSlotsList.fromJson(json.decode(response.body));
  }
}
