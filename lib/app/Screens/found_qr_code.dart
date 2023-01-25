// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_app/app/Screens/commom_functions.dart';
import 'package:qr_scanner_app/app/Screens/login.dart';
import 'package:qr_scanner_app/app/bloc/student_data_bloc.dart';
import 'package:qr_scanner_app/app/utilities/UserSecureStorage.dart';

import '../bloc/attendance_success_bloc.dart';

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function screenClosed;
  const FoundCodeScreen(
      {Key? key, required this.value, required this.screenClosed})
      : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  final audioPlayer = AudioPlayer();
   AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  late StudentDataBloc _studentDataBloc;
  late AttendanceSuccessBloc _attendanceSuccessBloc;
  late CommonFuntion _commonFuntion;
  @override
  void initState() {
     
    // audioPlayer.play(assets/audio/P3EsFcN_rRc.mp3);
    // assetsAudioPlayer.play();
    _attendanceSuccessBloc = AttendanceSuccessBloc();
    _studentDataBloc = StudentDataBloc();
    _commonFuntion = CommonFuntion();
    adharCardFormate();
    super.initState();
  }

  existToThisPage() {
    widget.screenClosed();
    Navigator.pop(context);
  }
  

  adharCardFormate() {
    String s = widget.value;
    var concatenate = StringBuffer();
    var x = s.split('-');
    for (var item in x) {
      concatenate.write(item);
    }

    print(concatenate);
    getStudentDataByAdharCard(concatenate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _commonFuntion.loaderHandlerShow(context),
    );
  }

  Future<void> showConfirm(confirmdata) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        
        return AlertDialog(
          title: const Text("Detail's"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Name :- " + confirmdata.name.toString()),
                Text(confirmdata.isStudent == true
                    ? "Class :- " + confirmdata!.position.toString()
                    : "Designation :- " + confirmdata!.position.toString()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
                existToThisPage();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                addAttendence(confirmdata.id,confirmdata.isStudent);
              },
            ),
          ],
        );
      },
    );
  }

  addAttendence(id, isStudent) async {
    Navigator.pop(context);
    _commonFuntion.loaderHandlerShow(context);

    final result =
        await _attendanceSuccessBloc.fetchStudentAttendance(id, isStudent).then(
      (value) {
        _commonFuntion.loaderHandlerHide();
        attendanceDone(true,value!.message);
      value.message =="Employee Is In" ?  assetsAudioPlayer.open(Audio('assets/audio/InAudio.mp3'),
            autoStart: true):assetsAudioPlayer.open(Audio('assets/audio/OutAudio.mp3'),
        autoStart: true);
      },
    ).catchError((err) {
      _commonFuntion.loaderHandlerHide();

      print("error is that" + err.toString());
      err == 208
          ? attendanceDone(false,err)
          : err == 401
              ? unAuthorized()
              : "";
    }).whenComplete(() {
      _commonFuntion.loaderHandlerHide();
    });

    print("result is that " + result.toString());
  }

  getStudentDataByAdharCard(aadharCardNum) async {
    final studentData =
        await _studentDataBloc.fetchStudentData(aadharCardNum).then(
      (value) {
        print("Student data " + value!.position.toString());
        _commonFuntion.loaderHandlerHide();
        value.isStudent == true?userNotFound("Data Not found"): showConfirm(value);

        // existToThisPage();
      },
    ).catchError((onError) {
      _commonFuntion.loaderHandlerHide();
      onError == 401 ? unAuthorized() : userNotFound("Data Not found");
    });
  }

  Future<void> attendanceDone(status,msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          existToThisPage();
          Navigator.pop(context);
        });
        return AlertDialog(
          // title: ,
          content: SingleChildScrollView(
            child: status == false
                ? Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(65),
                        ),
                        child: const Icon(Icons.warning_amber,
                            color: Colors.white, size: 32),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Attendance Has Already Been Taken")
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(65),
                            color: Colors.green),
                        child: const Icon(Icons.done_rounded,
                            color: Colors.white, size: 32),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Text(msg)
                    ],
                  ),
          ),
          
        );
      },
    );
  }

  unAuthorized() async {
    await userNotFound("Token Expire Login Again");
    await UserSecureStorage.removeToken();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (contex) => const LoginScreen()),
        (route) => false);
  }

  Future<void> userNotFound(msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          existToThisPage();
          Navigator.pop(context);
        });
        return AlertDialog(
          // title: ,
          content: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(65),
                ),
                child: const Icon(Icons.highlight_remove_sharp,
                    color: Colors.white, size: 32),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(msg)
            ],
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                existToThisPage();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
