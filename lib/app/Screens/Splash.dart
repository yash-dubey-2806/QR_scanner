import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:intl/intl.dart';
import 'package:qr_scanner_app/app/Screens/login.dart';
import 'package:qr_scanner_app/main.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

import '../utilities/UserSecureStorage.dart';

class Splash extends StatefulWidget {
  static late BuildContext baseContext;

  const Splash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  late int finalToken;

  @override
  void initState() {
 
    super.initState();
    init();
  }

  @override
  Future init() async {
    final token = await UserSecureStorage.getLoginTime() ?? '';
    
    setState(() {
      finalToken = int.parse(token.toString());
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SSISM Attendance",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: 0,
              child: _buildChild(),
            ),
            Container(
              child: AnimatedSplashScreen(
                  duration: 3000,
                  animationDuration:const Duration(milliseconds: 1650),
                  splash: 'assets/images/Ssism_Logo_01.png',
                  splashIconSize: 200,
                  // nextScreen: ScanScreen(),
                  nextScreen: _buildChild(),
                  splashTransition: SplashTransition.fadeTransition,
                  backgroundColor: Colors.white),
            ),
          ],
        ),
      ),
   
    );
  }

  Widget _buildChild() {
      final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('h');
    final String formatted = formatter.format(now);
    var data = int.parse(formatted.toString());

    // print("finalToken");
    if (data >  finalToken) {
      return  SplashScreen(
        seconds: 3,
        navigateAfterSeconds:const HomePage(),
      );
    } else {
      // print("else part");
      return  SplashScreen(
        seconds: 3,
        navigateAfterSeconds:const LoginScreen(),
        // navigateAfterSeconds: AddFarmers(),
      );
    }
  }
}
