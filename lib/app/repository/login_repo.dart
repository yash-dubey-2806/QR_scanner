import 'package:qr_scanner_app/app/models/login_reponse.dart';
import 'package:qr_scanner_app/app/utilities/Constants.dart';

import '../networking/api_base_helper.dart';
import '../utilities/UserSecureStorage.dart';

class LoginRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  fetchLogin(data) async {
    final response =
        await _helper.post(Constants.LOGIN_URL, data, Constants.BASEURL);
    await UserSecureStorage.setToken(response['token']);
    await UserSecureStorage.setUserId(response['userId']);
    await UserSecureStorage.setUsername(response['user']);
    await UserSecureStorage.setEmail(response['email']);
    await UserSecureStorage.setRole(response['role']);

    print("Get login on repo= $response");
    return LoginResponse.fromJson(response);
  }
}
