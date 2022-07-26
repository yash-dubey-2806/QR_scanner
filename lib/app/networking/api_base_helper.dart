// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:io';
// import 'package:bharosa_safecrop_fe_0_1/app/models/UserResponse.dart';

// import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:qr_scanner_app/app/networking/api_exceptions.dart';
import 'package:qr_scanner_app/app/utilities/Constants.dart';

import '../utilities/RequestInterceptor.dart';

class ApiBaseHelper {
  final http = InterceptedHttp.build(interceptors: [
    RequestInterceptor(),
  ]);

  var apiPort = Constants.BASEURL ;
  

  Future<dynamic> get(String url, apiPortType) async {
    
    var responseJson;
    try {
      print("API Base URL $apiPort$url");
      final response = await http.get(Uri.parse(apiPort + url)  );
      responseJson = _returnResponse(response);
      // print("API Response $responseJson");
    } on SocketException {
      print('No net');
      throw 'No Internet connection';
    }
    // print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic user, apiPortType) async {
    var responseJson;
    var data = json.encode(user);
    try {
      print("API Base URL $apiPort$url");
      final response = await http.post(Uri.parse(apiPort + url), body: data);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw 'No Internet connection';
    }

    print('api post.');
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic user, apiPortType) async {
    var responseJson;
    var data = json.encode(user);
    try {
      // print("API Base URL $apiPort$url");
      final response = await http.put(Uri.parse(apiPort + url), body: data);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw 'No Internet connection';
    }
    print('api put.');
    // print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> delete(String url, dynamic delete, apiPortType) async {
    var responseJson;
    var data = json.encode(delete);
    try {
      print("API Base URL $apiPort$url");
      final response = await http.delete(Uri.parse(apiPort + url), body: data);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw 'No Internet connection';
    }
    print('api delete.');
    return responseJson;
  }

  Future<dynamic> deleteWithParams(String url, apiPortType) async {
    var responseJson;
    try {
      print("API Base URL $apiPort$url");
      final response = await http.delete(Uri.parse(apiPort + url));
      responseJson = _returnResponse(response);
      // print("API Response $responseJson");
    } on SocketException {
      print('No net');
      throw 'No Internet connection';
    }
    // print('api get recieved!');
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(utf8.decode(response.bodyBytes));
      // print(responseJson);

      return responseJson;
    case 400:
      throw response.statusCode;
    case 208:
      throw response.statusCode;

    case 404:
    throw response.statusCode;
    case 401:
    case 415:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

String errorCodeResponse(String error) {
  print("ishere"+ error.toString());
  // int errorCode = int.parse(error);
  // print(errorCode);
  switch (101) {
    case 101:
      return error;
    case 400:
      return error;
    default:
      throw CustomRequestException(
          'Error occured while Communication with Server with StatusCode : 101');
  }
}
