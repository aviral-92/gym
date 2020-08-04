import 'package:flutter/material.dart';
import 'Screens/CancelBookingScreen.dart';
import 'Screens/UpcomingEventScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/SignupScreen.dart';
import 'Screens/DashboardScreen.dart';
import 'Screens/Contact.dart';
import 'Screens/admin/AddSlotScreen.dart';
import 'Screens/BookingScreen.dart';
import 'Screens/PasswordResetScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.amber,
        //backgroundColor: Colors.orangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (ctx) => HomeScreen(),
        '/login-screen': (ctx) => LoginScreen(),
        '/signup-screen': (ctx) => SignupScreen(),
        '/dashboard-screen': (ctx) => DashboardScreen(),
        '/upcoming-screen': (ctx) => UpcomingEventScreen(),
        '/booking-screen': (ctx) => BookingScreen(),
        '/cancel-screen': (ctx) => CancelBookingScreen(),
        '/add-screen': (ctx) => AddSlotScreen(),
        '/contact-screen': (ctx) => Contact(),
        '/reset-password-screen': (ctx) => PasswordResetScreen(),
        '/logout-screen': (_) => new LoginScreen(),
      },
    );
  }
}
