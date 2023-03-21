import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const dev = 'http://10.0.2.2:3000/';
const prod = 'https://k6kk3hg2r6.execute-api.ap-south-1.amazonaws.com/dev/';

class Auth with ChangeNotifier {
  String _token = '';
  String _userId = '';
  String _username = '';

  String get isAuth {
    return _token;
  }

  String get userId {
    return _userId;
  }

  String get username {
    return _username;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse('${prod}api/partner/login');
    try {
      final response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            'fcmtoken': fcmToken,
            'email': email,
            'password': password,
          },
        ),
      );

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print(responseData);
      }

      _token = responseData["token"];
      _userId = responseData["serviceProvider"]["_id"];
      _username = responseData["serviceProvider"]["name"];

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'username': _username,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      rethrow;
    }
  }

  Future<void> register(
    String firstname,
    String lastname,
    String phonenumber,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    final url = Uri.parse('${prod}api/partner/register');

    try {
      final response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            'firstname': firstname,
            'lastname': lastname,
            'email': email,
            'phonenumber': phonenumber,
            'password': password,
          },
        ),
      );
      final responseData = jsonDecode(response.body);

      _token = responseData["token"];
      _userId = responseData["serviceProvider"]["_id"];
      _username = responseData["serviceProvider"]["name"];

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'username': _username,
      });
      prefs.setString('userData', userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'login');
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return;
    }

    final userData = prefs.getString('userData');

    final extractedUserData = jsonDecode(userData!);

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _username = extractedUserData['username'];

    notifyListeners();
  }

  Future<void> logout() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_token',
    };

    final url = Uri.parse('${prod}api/partner/logout');
    try {
      final response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            'token': _token,
          },
        ),
      );

      final responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
      }
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (error) {
      rethrow;
    }
  }
}
