import 'package:Gym/constants/Constants.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final bool _admin;

  MainDrawer(this._admin) {
    //this._admin = args;
  }

  Widget listTileWidget(String title, IconData icons, Function fun) {
    return ListTile(
      leading: Icon(
        icons,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: () => fun(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Constants.APP_BAR_COLOR, //Theme.of(context).accentColor,
            //decoration: BoxDecoration(color: ),
            child: Text(
              'Welcome Aboard',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20),
          listTileWidget('Upcoming Schedule', Icons.calendar_today,
              () => navigateUpcomingEvent(context)),
          listTileWidget('Book Slot', Icons.accessibility,
              () => navigateBookingEvent(context)),
          listTileWidget(
              'Update Slot', Icons.update, () => navigateUpdateEvent(context)),
          listTileWidget(
              'Cancel Slot', Icons.cancel, () => navigateCancelEvent(context)),
          _admin == true
              ? listTileWidget(
                  'Add Slot', Icons.add, () => navigateAddEvent(context))
              : Text(''),
        ],
      ),
    );
  }

  void navigateUpcomingEvent(BuildContext context) {
    //print(_admin);
    Navigator.of(context).pushNamed('/upcoming-screen', arguments: _admin);
  }

  void navigateBookingEvent(BuildContext context) {
    Navigator.of(context).pushNamed('/booking-screen', arguments: _admin);
  }

  void navigateUpdateEvent(BuildContext context) {
    Navigator.of(context).pushNamed('/update-screen', arguments: _admin);
  }

  void navigateAddEvent(BuildContext context) {
    Navigator.of(context).pushNamed('/add-screen', arguments: _admin);
  }

  void navigateCancelEvent(BuildContext context) {
    Navigator.of(context).pushNamed('/cancel-screen', arguments: _admin);
  }
}
