import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class Api {
  String baseUrl = apiLink + '/api/';

  //Get data method
  Future getData(String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }

  //Post lorin method
  Future postData(Map data, String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data));
    return response;
  }

  //Post lorin method
  Future loginRegister(Map data, String endPoint) async {
    String url = baseUrl + endPoint;
    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json'
        },
        body: jsonEncode(data));
    return response;
  }

  //Post register user data
  Future registerUser(Map data, String endPoint) async {
    String url = baseUrl + endPoint;
    var response = await http.post(url,
        headers: {
          'Content-type': 'application/json',
        },
        body: jsonEncode(data));
    return response;
  }

  Future deleteData(String endPoint) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    String url = baseUrl + endPoint;
    var response = await http.delete(url, headers: {
      'Accept': 'application/json',
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }
}
