import 'package:Gym/Screens/LoginSignupScreen.dart';
import 'package:Gym/Screens/NewDashboardScreen.dart';
import 'package:Gym/Screens/admin/GetItemScreen.dart';
import 'package:Gym/Screens/admin/ViewBookingScreen.dart';
import 'package:Gym/services/RestApiService.dart';
//import 'Screens/ImageGalaryScreen.dart';
import 'Screens/admin/AddItemScreen.dart';
import 'package:flutter/material.dart';
import 'Screens/CancelBookingScreen.dart';
import 'Screens/UpcomingEventScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/SignupScreen.dart';
import 'Screens/Contact.dart';
import 'Screens/admin/AddSlotScreen.dart';
import 'Screens/PasswordResetScreen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isLoggedIn = getLoggedInState();
  await isLoggedIn.then((value) => {
        isAdminState().then(
          (admin) => runApp(MyApp(value, admin)),
        ),
      });
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isAdmin;
  MyApp(this.isLoggedIn, this.isAdmin);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoggedIn == true
          ? NewDashboardScreen(
              args: isAdmin,
            )
          : HomeScreen(),
      routes: {
        '/login-screen': (ctx) => LoginScreen(),
        '/signup-screen': (ctx) => SignupScreen(),
        '/dashboard-screen': (ctx) => NewDashboardScreen(),
        '/upcoming-screen': (ctx) => UpcomingEventScreen(),
        // '/booking-screen': (ctx) => BookingScreen(0),
        '/cancel-screen': (ctx) => CancelBookingScreen(),
        '/add-screen': (ctx) => AddSlotScreen(),
        '/add-item-screen': (ctx) => AddItemScreen(),
        '/contact-screen': (ctx) => Contact(),
        '/reset-password-screen': (ctx) => PasswordResetScreen(),
        '/login-signup-screen': (ctx) => LoginSignUpScreen(),
        '/delete-update-item-screen': (ctx) => GetItemScreen(),
        '/view-booking-screen': (ctx) => ViewBookingScreen(),
        //'/delete-screen': (ctx) => NotificationService(),
      },
    );
  }
}
