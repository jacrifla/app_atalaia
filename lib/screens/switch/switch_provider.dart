import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../utils/config.dart';
import 'switch_model.dart';
import '../../utils/auth_storage.dart';

class SwitchProvider extends ChangeNotifier {
  List<SwitchModel> _switches = [];
  List<SwitchModel> get switches => _switches;

  void setSwitches(List<SwitchModel> switches) {
    _switches = switches;
    notifyListeners();
  }

  Future<void> fetchSwitches() async {
    try {
      final Dio dio = Dio();
      final userUuid = await AuthStorage.readUuid();

      final response = await dio.get(
        '${Config.apiUrl}switches',
        queryParameters: {'user_uuid': userUuid},
      );

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
