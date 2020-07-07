import './Screens/CancelBookingScreen.dart';
import './Screens/UpcomingEventScreen.dart';
import './Screens/dashboard_screen.dart';
import './Screens/login_screen.dart';
import './Screens/signup_screen.dart';
import './Screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'Screens/BookingScreen.dart';

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
      },
    );
  }
}
