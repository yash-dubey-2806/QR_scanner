import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_scanner_app/app/Screens/commom_functions.dart';
import 'package:qr_scanner_app/app/Screens/login.dart';
import 'package:qr_scanner_app/app/Screens/qr_scaner.dart';
import 'package:qr_scanner_app/app/utilities/UserSecureStorage.dart';

import '../bloc/login_bloc.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? finalToken;
  late String email, password;
  late LoginBloc _loginBloc;
  late CommonFuntion _commonFuntion;

  @override
  void initState() {
    _commonFuntion = CommonFuntion();
    _loginBloc = LoginBloc();
    setLocal();
    super.initState();
  }

  setLocal() async {
    final acess = await UserSecureStorage.getLoginTime();
    print("final acess$acess");
    acess == null ? await UserSecureStorage.setLoginTime(30.toString()) : "";
    final dateChecking = await UserSecureStorage.getLoginDate();
    print("final dateChecking$dateChecking");
    dateChecking == null
        ? await UserSecureStorage.setLoginDate(30.toString())
        : "";

    _buildChild();
  }

  autoLogin() async {
    // _commonFuntion.loaderHandlerShow(context);
    var loginData = {
      "email": "deepsingh@ssism.org",
      "password": "ssism@deepsingh"
    };
    // var loginData = {"email": email, "password": password};
    final loginResponse = await _loginBloc.fetchLogin(loginData).then((value) {
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('h');
      final String formatted = formatter.format(now);
      print(formatted);
      final dateFormatter = DateFormat.yMd();
      final String formatteddat = dateFormatter.format(now);
      print(formatteddat);

      var data = int.parse(formatted.toString());

      print((data + 3).toString());

      UserSecureStorage.setLoginTime((data + 3).toString());
      UserSecureStorage.setLoginDate(formatteddat.toString());

      // something like 2013-04-20

      // _commonFuntion.loaderHandlerHide();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const QRScaner()),
          (Route<dynamic> route) => false);
    }).catchError((err) {
      // _commonFuntion.loaderHandlerHide();
      print("error is that $err");

      _commonFuntion.snackBar(
          err == 404
              ? "User Not Found"
              : err == 400
                  ? "Invalid Cradential"
                  : err.toString(),
          context);
    });
    print("Login Response  $loginResponse");
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

  _buildChild() async {
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
      if (valuefinal != 30 &&
          data <= valuefinal &&
          dateIsThat == formatteddat) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const QRScaner()),
            (route) => false);
      } else {
        autoLogin();
//  Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreen()),
//           (route) => false);
      }
    });
  }
}
