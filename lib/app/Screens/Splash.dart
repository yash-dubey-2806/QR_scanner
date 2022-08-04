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
    setLocal();
    super.initState();
  }

  setLocal()async{
   final acess =  await UserSecureStorage.getLoginTime();
   print("final acess"+ acess.toString());
   acess == null ?
   await UserSecureStorage.setLoginTime(30.toString()):"";
   final dateChecking =  await UserSecureStorage.getLoginDate();
   print("final dateChecking"+ dateChecking.toString());
   dateChecking == null ?
   await UserSecureStorage.setLoginDate(30.toString()):"";

       _buildChild();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Attendance App",
      debugShowCheckedModeBanner: false,
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
    final dateIsThat = await UserSecureStorage.getLoginDate();
    var valuefinal = int.parse(value.toString());
    var data = int.parse(formatted.toString());
    final dateFormatter = DateFormat.yMd();
    final String formatteddat = dateFormatter.format(now);
    print(formatteddat);

    Timer(const Duration(seconds: 4), () {
      if( valuefinal != 30 && data <= valuefinal && dateIsThat == formatteddat ){
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
