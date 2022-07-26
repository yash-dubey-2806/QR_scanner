

import 'package:qr_scanner_app/app/models/student_data_response.dart';
import 'package:qr_scanner_app/app/repository/student_data_repo.dart';

class StudentDataBloc {
  late StudentRepository _studentRepository;

  StudentDataBloc() {
    _studentRepository = StudentRepository();
  }

  Future<StudentDataResponce?> fetchStudentData(loginData) async {
    StudentDataResponce? loginRespone = await _studentRepository.fetchStudentData(loginData);

    return loginRespone;
  }
}
