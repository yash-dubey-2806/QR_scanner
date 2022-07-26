
import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:qr_scanner_app/app/utilities/UserSecureStorage.dart';

class RequestInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    var token = await UserSecureStorage.getToken();
    var latitude = await UserSecureStorage.getLatitude();
    var longitude = await UserSecureStorage.getLongitude();
    // AuthRepository authRepository = new AuthRepository();
    try {
      data.headers[HttpHeaders.contentTypeHeader] = "application/json";
      data.headers[HttpHeaders.acceptHeader] = "application/json";
      data.headers['app_type'] = '1';
      data.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      

      if (latitude == null) {
        data.headers['latitude'] = 'NA';
        data.headers['longitude'] = 'NA';
      } else {
        data.headers['latitude'] = '$latitude';
        data.headers['longitude'] = '$longitude';
      }
    } catch (e) {
      // print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }

  bool isTokenExpired(String _token) {
    DateTime? expiryDate = Jwt.getExpiryDate(_token);
    // print(expiryDate);
    bool isExpired = expiryDate!.compareTo(DateTime.now()) < 0;
    // print("isExpired:$isExpired");
    return isExpired;
  }
}
