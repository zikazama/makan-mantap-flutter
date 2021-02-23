import 'package:dicoding_news_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_news_app/ui/restaurant_list_page.dart';
import 'package:dicoding_news_app/utils/background_service.dart';
import 'package:dicoding_news_app/utils/notification_helper.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  List<Widget> _listWidget = [RestaurantListPage()];

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[0],
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(child: _listWidget[0]);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
