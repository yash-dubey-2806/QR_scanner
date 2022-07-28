import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_scanner_app/app/Screens/login.dart';
import 'package:qr_scanner_app/app/Screens/qr_scaner.dart';
import 'package:qr_scanner_app/app/utilities/UserSecureStorage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? finalToken;

  @override
  void initState() {
    _buildChild();
    super.initState();
  }

  Locale? _locale;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Attendance App",
      debugShowCheckedModeBanner: false,
      locale: _locale,
      home: Scaffold(
        body: Stack(
          fit: StackFit.loose,
          children: [
            AnimatedContainer(
              curve: Curves.bounceInOut,
              duration: const Duration(seconds: 3),
              child: Center(
                child: Image.asset(
                  'assets/images/Ssism_Logo_01.png',
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  _buildChild() async{
     final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('h');
    final String formatted = formatter.format(now);
    print(formatted);
    final value = await UserSecureStorage.getLoginTime();
    var valuefinal = int.parse(value.toString());
    var data = int.parse(formatted.toString());

    Timer(const Duration(seconds: 4), () {
      if( valuefinal != 30 && data <= valuefinal ){
 Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const QRScaner()),
          (route) => false);
      }
     else{
 Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
      }
    });
  }
}
