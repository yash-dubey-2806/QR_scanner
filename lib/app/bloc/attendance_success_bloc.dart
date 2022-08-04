

import 'package:qr_scanner_app/app/models/attendance_success_response.dart';
import 'package:qr_scanner_app/app/repository/attendance_success_repo.dart';

class AttendanceSuccessBloc {
  late AttendanceSuccessRepository _attendanceSuccessRepository;

  AttendanceSuccessBloc() {
    _attendanceSuccessRepository = AttendanceSuccessRepository();
  }

  Future<AttendanceSuccessResponse?> fetchStudentAttendance(loginData,isStudent) async {
    AttendanceSuccessResponse? loginRespone =
        await _attendanceSuccessRepository.fetchStudentAttendance(loginData,isStudent);

    return loginRespone;
  }
}
