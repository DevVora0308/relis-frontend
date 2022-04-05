import 'dart:async';
import 'package:flutter/material.dart';
import 'package:relis/authentication/signIn.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/SplashPage';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoading = true;
  //creating the timer that stops the loading after 15 secs
  void startTimer() {
    Timer.periodic(const Duration(seconds: 5), (t) {
      t.cancel(); //stops the timer
      isLoading = false;
      setState(() {});
      _checker();
    });
  }

  @override
  void initState() {
    startTimer(); //start the timer on loading
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // User result = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Color(0xFFdbb018),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            background(),
            CircularProgressIndicator(
              valueColor:
              new AlwaysStoppedAnimation<Color>(Color(0xFF032f4b)),
            ),
          ],
        ),
      ),
    );
  }

  _checker() {
    Navigator.of(context).popAndPushNamed(SignInPage.routeName);
  }

  background() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.00),
        child: Image.asset('ReLis.gif', fit: BoxFit.fill,),
      ),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(25.0),
        border: Border.all(color: Color(0xFF032f4b), width: 15.0),
        color: Color(0xFF032f4b),
      ),
    );
  }
}