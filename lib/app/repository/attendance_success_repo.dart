

import 'package:qr_scanner_app/app/models/attendance_success_response.dart';

import '../networking/api_base_helper.dart';
import '../utilities/Constants.dart';

class AttendanceSuccessRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  fetchStudentAttendance(data) async {
    final response = await _helper.get(
        Constants.ATTENDANCE_SUCCESS + data, Constants.BASEURL);

    print("Get login on repo= $response");
    return AttendanceSuccessResponse.fromJson(response);
  }
}
