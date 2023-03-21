import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

const dev = 'http://10.0.2.2:3000/';
const prod = 'https://k6kk3hg2r6.execute-api.ap-south-1.amazonaws.com/dev/';

class Salon with ChangeNotifier {
  final String token;
  final String userId;
  Salon(this.token, this.userId);

  Map<String, dynamic> _salonInformation = {};

  bool _loading = false;

  bool _homepageLoading = false;

  bool get homepageLoading {
    return _homepageLoading;
  }

  bool get loading {
    return _loading;
  }

  List<dynamic> _bookings = [];

  final Map<String, String> _salonData = {
    "shopName": "",
    "streetAddress": "",
    "landmark": "",
    "city": "",
    "pincode": "",
    "district": "",
    "state": "",
    "latitude": "",
    "longitude": "",
    "Monday": "",
    "Monday opening time": "",
    "Monday closing time": "",
    "Tuesday": "",
    "Tuesday opening time": "",
    "Tuesday closing time": "",
    "Wednesday": "",
    "Wednesday opening time": "",
    "Wednesday closing time": "",
    "Thursday": "",
    "Thursday opening time": "",
    "Thursday closing time": "",
    "Friday": "",
    "Friday opening time": "",
    "Friday closing time": "",
    "Saturday": "",
    "Saturday opening time": "",
    "Saturday closing time": "",
    "Sunday": "",
    "Sunday opening time": "",
    "Sunday closing time": "",
    "hairCut": "",
    "Hair Cut Amount": "",
    "Hair Cut Time": "",
    "shaving": "",
    "Shaving Amount": "",
    "Shaving Time": "",
    "massage": "",
    "Head Massage Amount": "",
    "Head Massage Time": "",
    "fcmtoken": "",
  };

  final Map<String, String> _salonBasicData = {
    "shopName": "",
  };

  final Map<String, String> _salonAddressData = {
    "streetAddress": "",
    "landmark": "",
    "city": "",
    "pincode": "",
    "district": "",
    "state": "",
    "latitude": "",
    "longitude": "",
  };

  final Map<String, String> _salonTimingData = {
    "Monday": "",
    "Monday opening time": "",
    "Monday closing time": "",
    "Tuesday": "",
    "Tuesday opening time": "",
    "Tuesday closing time": "",
    "Wednesday": "",
    "Wednesday opening time": "",
    "Wednesday closing time": "",
    "Thursday": "",
    "Thursday opening time": "",
    "Thursday closing time": "",
    "Friday": "",
    "Friday opening time": "",
    "Friday closing time": "",
    "Saturday": "",
    "Saturday opening time": "",
    "Saturday closing time": "",
    "Sunday": "",
    "Sunday opening time": "",
    "Sunday closing time": "",
  };

  final Map<String, String> _salonServicesData = {
    "hairCut": "",
    "Hair Cut Amount": "",
    "Hair Cut Time": "",
    "shaving": "",
    "Shaving Amount": "",
    "Shaving Time": "",
    "massage": "",
    "Head Massage Amount": "",
    "Head Massage Time": "",
  };

  Map<String, dynamic> get salonData {
    return _salonData;
  }

  Map<String, String> get salonBasicData {
    return _salonBasicData;
  }

  void changeSalonBasicData(String name, String value) {
    _salonBasicData[name] = value;
  }

  Map<String, String> get salonAddressData {
    return _salonAddressData;
  }

  void changeSalonAddressData(String name, String value) {
    _salonAddressData[name] = value;
  }

  Map<String, String> get salonTimingData {
    return _salonTimingData;
  }

  void changeSalonTimingData(String name, String value) {
    _salonTimingData[name] = value;
  }

  Map<String, String> get salonServicesData {
    return _salonServicesData;
  }

  void changeSalonServicesData(String name, String value) {
    _salonServicesData[name] = value;
  }

  Map<String, dynamic> get salonInformation {
    return _salonInformation;
  }

  List<dynamic> get bookings {
    return _bookings;
  }

  void changeSalonData(String name, String value) {
    _salonData[name] = value;
  }

  Future<void> addSalonInformation() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse('${prod}api/partner/addsalon');
    final fcmToken = await FirebaseMessaging.instance.getToken();
    _salonData['fcmtoken'] = fcmToken!;
    try {
      final response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(_salonData),
      );
      final responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print("the data is: $responseData");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getSalonInformation() async {
    _homepageLoading = true;
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('${prod}api/partner/getsalon');
    try {
      final response = await http.get(
        url,
        headers: requestHeaders,
      );

      final responseData = jsonDecode(response.body);
      if (responseData['salonInformation'] != null) {
        _salonInformation = responseData['salonInformation'];
        _bookings = _salonInformation['bookings'];
      }
      _homepageLoading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateSalonBasicDetials() async {
    _loading = true;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('${prod}api/partner/updatebasicdetails');
    try {
      final response = await http.patch(
        url,
        headers: requestHeaders,
        body: jsonEncode(_salonBasicData),
      );
      jsonDecode(response.body);
      _loading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateSalonAddressDetails() async {
    _loading = true;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('${prod}api/partner/updateaddressdetails');
    try {
      final response = await http.patch(
        url,
        headers: requestHeaders,
        body: jsonEncode(_salonAddressData),
      );
      jsonDecode(response.body);
      _loading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateSalonTimingDetails() async {
    _loading = true;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('${prod}api/partner/updatetimingdetails');
    try {
      final response = await http.patch(
        url,
        headers: requestHeaders,
        body: jsonEncode(_salonTimingData),
      );

      jsonDecode(response.body);

      _loading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateSalonServiceDetails() async {
    _loading = true;
    notifyListeners();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('${prod}api/partner/updateservicedetails');
    try {
      final response = await http.patch(
        url,
        headers: requestHeaders,
        body: jsonEncode(_salonServicesData),
      );
      jsonDecode(response.body);
      _loading = false;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
