import 'package:Gym/constants/Constants.dart';
import 'package:Gym/constants/Routing.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final bool _admin;

  MainDrawer(this._admin);

  Widget listTileWidget(String title, IconData icons, Function fun) {
    return ListTile(
      leading: Icon(
        icons,
        size: Constants.DRAWER_ICON_SIZE,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: Constants.DRAWER_FONT_SIZE,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: () => fun(),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* Routing table to route */
    Routing routing = new Routing(_admin);
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
                'Welcome to \n The Fitness Place',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            listTileWidget('Home', Icons.home,
                () => routing.navigateHomeDashboardEvent(context)),
            listTileWidget('Upcoming Schedule', Icons.calendar_today,
                () => routing.navigateUpcomingEvent(context)),
            /*listTileWidget('Book Class', Icons.accessibility,
                () => routing.navigateBookingEvent(context)),*/
            listTileWidget('Cancel Class', Icons.cancel,
                () => routing.navigateCancelEvent(context)),
            listTileWidget('Contact Us', Icons.contacts,
                () => routing.navigateContactEvent(context)),
            listTileWidget('Password Reset', Icons.contacts,
                () => routing.navigateResetPasswordEvent(context)),
            listTileWidget('Image Galary', Icons.contacts,
                () => routing.navigateImageGalaryEvent(context)),
            listTileWidget('Logout', Icons.contacts,
                () => Routing.navigateLogout(context)),
            _admin == true
                ? ExpansionTile(
                    title: Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    leading: Icon(Icons.alternate_email),
                    //trailing: null,
                    children: <Widget>[
                      SizedBox(
                        // height: 280,
                        child: Column(
                          children: <Widget>[
                            listTileWidget('Add item', Icons.add_to_photos,
                                () => routing.navigateAddItemEvent(context)),
                            listTileWidget('Add slot', Icons.add_to_photos,
                                () => routing.navigateAddEvent(context)),
                            listTileWidget('View booking slot', Icons.view_list,
                                () => routing.navigateViewvent(context)),
                            listTileWidget('Delete slot', Icons.delete_forever,
                                () => routing.navigateDeleteEvent(context)),
                            listTileWidget(
                                'Update/Delete item',
                                Icons.delete,
                                () => routing
                                    .navigateDeleteOrUpdateItemEvent(context)),
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
}
