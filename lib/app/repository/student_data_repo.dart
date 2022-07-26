
import 'package:qr_scanner_app/app/models/student_data_response.dart';
import 'package:qr_scanner_app/app/utilities/Constants.dart';

import '../networking/api_base_helper.dart';

class StudentRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  fetchStudentData(data) async {
    final response =
        await _helper.get(Constants.GET_ADHARCARD_STATUS_URL + "/$data", Constants.BASEURL);
   
    print("Get login on repo= $response");
    return StudentDataResponce.fromJson(response);
  }
}
