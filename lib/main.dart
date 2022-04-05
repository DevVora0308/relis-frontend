import 'package:flutter/material.dart';
import 'package:relis/authentication/otp.dart';
import 'package:relis/authentication/signIn.dart';
import 'package:relis/authentication/signUp.dart';
import 'package:relis/globals.dart';
import 'package:relis/profile/showPhoto.dart';
import 'package:relis/view/bookView.dart';
import 'package:relis/view/homePage.dart';
import 'package:relis/view/pageView.dart';
import 'package:relis/profile/profile.dart';
import 'package:relis/view/searchPage.dart';
import 'package:relis/view/splashScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(ReLis());
}

class ReLis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: appTheme,
      initialRoute: SplashPage.routeName,
      // initialRoute: HomePage.routeName,
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
    );
  }
}
