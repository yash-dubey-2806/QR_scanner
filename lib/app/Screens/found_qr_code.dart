// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:qr_scanner_app/app/Screens/commom_functions.dart';
import 'package:qr_scanner_app/app/bloc/student_data_bloc.dart';

import '../bloc/attendance_success_bloc.dart';

class FoundCodeScreen extends StatefulWidget {
  final String value;
  final Function screenClosed;
  const FoundCodeScreen({Key? key,required this.value , required this.screenClosed}) : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
   late StudentDataBloc _studentDataBloc;
  late AttendanceSuccessBloc _attendanceSuccessBloc;
  late CommonFuntion _commonFuntion;
  @override
  void initState() {
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
    return  Scaffold(
      body:     _commonFuntion.loaderHandlerShow(context),

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
                Text("Name :- " +
                    confirmdata.data.firstName.toString() +
                    " " +
                    confirmdata.data.lastName.toString()),
                Text("Class :- " +
                    confirmdata.data.branch.toString() +
                    " " +
                    confirmdata.data.currentYear),
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
                Navigator.pop(context);
                _commonFuntion.loaderHandlerShow(context);
                final result = await _attendanceSuccessBloc
                    .fetchStudentAttendance(confirmdata.data.stdId)
                    .then(
                  (value) {
                    _commonFuntion.loaderHandlerHide();
                    attendanceDone(true);

                  },
                ).catchError((err) {
                                      _commonFuntion.loaderHandlerHide();

                  print("error is that" + err.toString());
                  err == 208 ? attendanceDone(false) : "";
                });

                print("result is that " + result.toString());
              },
            ),
          ],
        );
      },
    );
  }

  getStudentDataByAdharCard(aadharCardNum) async {
    final studentData =
        await _studentDataBloc.fetchStudentData(aadharCardNum).then(
      (value) {
        print("Student data " + value!.data.stdId);
        _commonFuntion.loaderHandlerHide();
        showConfirm(value);
        // existToThisPage();
      },
    ).catchError((onError){
              _commonFuntion.loaderHandlerHide();
              userNotFound();

    });
  }

  Future<void> attendanceDone(status) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          existToThisPage();
          Navigator.pop(context);
        });
        return AlertDialog(
          // title: ,
          content: SingleChildScrollView(
            child: status == false
                ? Column(
                    children:  [
                     Container(
                      width: 50,
                      height: 50,
                       decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(65),
                        ),
                        child:const Icon(Icons.warning_amber, color: Colors.white, size: 32),
                     ),
                     const SizedBox(height: 10,),
                     const Text("Attendance Has Already Been Taken")
                    ],
                  )
                : Column(
                    children:  [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(65),
                          color: Colors.green
                        ),
                        child:const Icon(Icons.done_rounded, color: Colors.white, size: 32),
                        ),
                      const SizedBox(
                        height: 10,
                      ),

                     const Text("SuccessFully Done")
                    ],
                  ),
          ),
          // actions: <Widget>[
          //   TextButton(
          //     child: const Text('Ok'),
          //     onPressed: () {
          //       existToThisPage();
          //       Navigator.pop(context);
          //     },
          //   ),
          // ],
        );
      },
    );
  }
  Future<void> userNotFound() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          existToThisPage();
          Navigator.pop(context);
        });
        return AlertDialog(
          // title: ,
          content: SingleChildScrollView(
            child:Column(
                    children:  [
                     Container(
                      width: 50,
                      height: 50,
                       decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(65),
                        ),
                        child:const Icon(Icons.highlight_remove_sharp,color: Colors.white, size: 32),
                     ),
                     const SizedBox(height: 10,),
                     const Text("Data Not found")
                    ],
                  )
                
          ),
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




