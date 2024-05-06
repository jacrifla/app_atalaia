import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'switch_model.dart';

class SwitchProvider extends ChangeNotifier {
  List<SwitchModel> _switches = [];

  List<SwitchModel> get switches => _switches;

  void setSwitches(List<SwitchModel> switches) {
    _switches = switches;
    notifyListeners();
  }

  Future<void> fetchSwitches(String userId) async {
    try {
      final Dio dio = Dio();

      final response = await dio.get(
          'http://192.168.1.25:80/app_atalaia/api2/switches',
          queryParameters: {'user_id': userId});

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        final List<SwitchModel> switches =
            responseData.map((data) => SwitchModel.fromJson(data)).toList();

        setSwitches(switches);
      } else {
        print('Failed to fetch switches. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching switches: $e');
    }
  }
}
