import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'app_exceptions.dart';

class ApiBaseHelper {
  static  String _baseUrl = "http://rohan4-001-site1.ftempurl.com/";


  static String get baseUrl => _baseUrl;

  Future<dynamic> get(String url) async {
    print('Api Get, url $url');
    print( _baseUrl + url);
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }
  Future<dynamic> getWithHeader(String url, String token) async {
    //print('Api Post, url $_baseUrl+url');
    print(_baseUrl+url);
    print('Api token, token $token');
    var responseJson;
    try {
      final response = await http.get(Uri.parse(_baseUrl + url),headers: {"Authorization": token});
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(responseJson);
    return responseJson;
  }

  Future<dynamic> post(String url, Map body) async {
    print(_baseUrl+url);
    print('Api Post, url $url');
    print(jsonEncode(body));
    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: jsonEncode(body),headers: {
        "Accept": "application/json",
        "content-type":"application/json"
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }
  Future<dynamic> postWithHeader(String url, Map body,String token) async {
    print(_baseUrl+url);
    print('Api token, token $token');

    print(jsonEncode(body));

    var responseJson;
    try {
      final response = await http.post(Uri.parse(_baseUrl + url), body: body,headers: {"Authorization": token});
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(responseJson);
    return responseJson;
  }


  Future<dynamic> put(String url, dynamic body) async {
    print('Api Put, url $url');
    var responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api put.');
    print(responseJson.toString());
    return responseJson;
  }

  Future<dynamic> deleteWithHeader(String url, String token) async {
    print('Api delete, url $url');
    print('$_baseUrl$url');
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url),headers: {"Authorization": token});
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    print(apiResponse);
    return apiResponse;
  }

  Future<dynamic> delete(String url) async {
    print('Api delete, url $url');
    var apiResponse;
    try {
      final response = await http.delete(Uri.parse(_baseUrl + url));
      apiResponse = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api delete.');
    return apiResponse;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      print(response.body.toString());
      var responseJson = json.decode(response.body.toString());
      // print(responseJson);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}