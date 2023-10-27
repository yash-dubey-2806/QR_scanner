import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_scanner_app/app/Screens/commom_functions.dart';
import 'package:qr_scanner_app/app/Screens/qr_scaner.dart';
import 'package:qr_scanner_app/app/bloc/login_bloc.dart';
import 'package:qr_scanner_app/app/utilities/UserSecureStorage.dart';
import 'package:qr_scanner_app/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String email, password;
  late LoginBloc _loginBloc;
  late CommonFuntion _commonFuntion;

  @override
  void initState() {
    _commonFuntion = CommonFuntion();
    _loginBloc = LoginBloc();
    super.initState();
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _login();
      print("Noerror");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
            child: Image(
              image: AssetImage("assets/images/Ssism_Logo_01.png"),
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofocus: true,
                      validator: (input) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(input.toString());
                        if (input!.isEmpty) {
                          return 'Required !';
                        } else if (emailValid == false) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email)),
                      onSaved: (input) => email = input!),
                  const SizedBox(height: 20),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Required !';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      onSaved: (input) => password = input!),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        child: const Text('LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GestureDetector(
          //   child: Text('Create an Account?'),
          //   onTap: () {},
          // )
        ],
      ),
    );
  }

  _login() async {
    _commonFuntion.loaderHandlerShow(context);
    var loginData = {"email": email, "password": password};
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

      _commonFuntion.loaderHandlerHide();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const QRScaner()),
          (Route<dynamic> route) => false);
    }).catchError((err) {
      _commonFuntion.loaderHandlerHide();
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
}
