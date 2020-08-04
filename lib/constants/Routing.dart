import 'package:flutter/material.dart';

class Routing {
  bool _admin;
  Routing(this._admin);

  static void navigateSignup(BuildContext context) =>
      Navigator.of(context).pushNamed('/signup-screen');

  static void navigateLogin(BuildContext context) =>
      Navigator.of(context).pushNamed('/login-screen');

  static void navigateLogout(BuildContext context) =>
      Navigator.of(context).pushReplacementNamed('/logout-screen');

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

  void navigateContactEvent(BuildContext context) =>
      Navigator.of(context).pushNamed('/contact-screen', arguments: _admin);

  void navigateResetPasswordEvent(BuildContext context) => Navigator.of(context)
      .pushNamed('/reset-password-screen', arguments: _admin);
}
