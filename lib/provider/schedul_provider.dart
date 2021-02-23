import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:dicoding_news_app/utils/background_service.dart';
import 'package:dicoding_news_app/utils/date_time_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulProvider extends ChangeNotifier {
  bool _isScheduled = false;

  SchedulProvider() {
    _checkIsScheduled();
  }

  bool get isScheduled => _isScheduled;

  Future<void> _checkIsScheduled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isScheduled = prefs.getBool('schedule') ?? false;
    notifyListeners();
  }

  Future<bool> scheduledResto(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isScheduled = value;
    await prefs.setBool('schedule', _isScheduled);

    if (_isScheduled) {
      print('Scheduling Resto Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Resto Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
