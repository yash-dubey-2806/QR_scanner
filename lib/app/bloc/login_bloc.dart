
import 'package:qr_scanner_app/app/models/login_reponse.dart';
import 'package:qr_scanner_app/app/repository/login_repo.dart';

class LoginBloc {
  late LoginRepository _loginRepository;

  LoginBloc() {
    _loginRepository = LoginRepository();
  }

  Future<LoginResponse?> fetchLogin(loginData) async {
    LoginResponse? loginRespone =
        await _loginRepository.fetchLogin(loginData);

    return loginRespone;
  
  }
}
