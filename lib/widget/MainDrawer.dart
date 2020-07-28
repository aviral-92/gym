import 'package:Gym/constants/Constants.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final bool _admin;

  MainDrawer(this._admin);

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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Constants.APP_BAR_COLOR,
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
            listTileWidget(
                'Home', Icons.home, () => navigateHomeDashboardEvent(context)),
            listTileWidget('Upcoming Schedule', Icons.calendar_today,
                () => navigateUpcomingEvent(context)),
            listTileWidget('Book Slot', Icons.accessibility,
                () => navigateBookingEvent(context)),
            /*listTileWidget('Update Slot', Icons.update,
                () => navigateUpdateEvent(context)),*/
            listTileWidget('Cancel Slot', Icons.cancel,
                () => navigateCancelEvent(context)),
            _admin == true
                ? ExpansionTile(
                    title: Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    leading: Icon(Icons.alternate_email),
                    //trailing: null,
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                        child: Column(
                          children: <Widget>[
                            listTileWidget('Add Slot', Icons.add_to_photos,
                                () => navigateAddEvent(context)),
                            /*listTileWidget('Get Slots', Icons.gesture,
                                () => navigateAddEvent(context)),
                            listTileWidget('Update Slot', Icons.update,
                                () => navigateAddEvent(context)),*/
                            listTileWidget('Delete Slot', Icons.delete_forever,
                                () => navigateAddEvent(context)),
                          ],
                        ),
                      )
                    ],
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }

  void navigateHomeDashboardEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/dashboard-screen', arguments: _admin);

  void navigateUpcomingEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/upcoming-screen', arguments: _admin);

  void navigateBookingEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/booking-screen', arguments: _admin);

  void navigateUpdateEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/update-screen', arguments: _admin);

  void navigateAddEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/add-screen', arguments: _admin);

  void navigateCancelEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/cancel-screen', arguments: _admin);
}
