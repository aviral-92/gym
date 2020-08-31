//import 'package:Gym/Screens/HomeScreen.dart';
import 'package:Gym/Screens/LoginSignupScreen.dart';
import 'package:Gym/services/RestApiService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Routing {
  bool _admin;
  Routing(this._admin);

  static void navigateSignup(BuildContext context) =>
      Navigator.of(context).pushNamed('/signup-screen');

  static void navigateLogin(BuildContext context) =>
      Navigator.of(context).pushNamed('/login-screen');

  static Future<void> navigateLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs?.setBool('isLoggedIn', false);
    await prefs.remove('isAdmin');
    await prefs.remove('Authorization');
    //print('Getting vlue======> ${prefs.getString('Authorization')}');
    await prefs.clear();
    //print('Pref got flushed=====> $resp');
    //flushStorage();
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return LoginSignUpScreen();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }),
        (Route route) => false);
    //Navigator.of(context).pushReplacementNamed('/logout-screen');
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

  void navigateViewvent(BuildContext context) => Navigator.of(context)
      .pushNamed('/view-booking-screen', arguments: _admin);

  void navigateDeleteEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/delete-screen', arguments: _admin);

  void navigateAddItemEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/add-item-screen', arguments: _admin);

  void navigateDeleteOrUpdateItemEvent(BuildContext context) =>
      Navigator.of(context)
          .pushNamed('/delete-update-item-screen', arguments: _admin);

  void navigateCancelEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/cancel-screen', arguments: _admin);

  void navigateContactEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/contact-screen', arguments: _admin);

  void navigateResetPasswordEvent(BuildContext context) => Navigator.of(context)
      .pushNamed('/reset-password-screen', arguments: _admin);

  void navigateImageGalaryEvent(BuildContext context) => Navigator.of(context)
      .pushNamed('/image-galary-screen', arguments: _admin);
}
