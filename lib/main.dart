import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_news_app/data/db/db_helper.dart';
import 'package:dicoding_news_app/provider/db_provider.dart';
import 'package:dicoding_news_app/provider/restaurant_detail_provider.dart';
import 'package:dicoding_news_app/provider/restaurant_provider.dart';
import 'package:dicoding_news_app/provider/restaurant_search_provider.dart';
import 'package:dicoding_news_app/provider/schedul_provider.dart';
import 'package:dicoding_news_app/ui/favorite_page.dart';
import 'package:dicoding_news_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_news_app/ui/restaurant_search_page.dart';
import 'package:dicoding_news_app/ui/home_page.dart';
import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/ui/setting_page.dart';
import 'package:dicoding_news_app/utils/background_service.dart';
import 'package:dicoding_news_app/utils/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'data/api/api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => RestaurantDetailProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => RestaurantSearchProvider(apiService: ApiService())),
        ChangeNotifierProvider(create: (_) => SchedulProvider()),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Makan Mantap',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
            textTheme: myTextTheme.apply(bodyColor: Colors.black),
            elevation: 0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: secondaryColor,
            unselectedItemColor: Colors.grey,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: secondaryColor,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                restaurant: ModalRoute.of(context).settings.arguments,
              ),
          RestaurantSearchPage.routeName: (context) => RestaurantSearchPage(),
          SettingPage.routeName: (context) => SettingPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
        },
      ),
    );
  }
}
