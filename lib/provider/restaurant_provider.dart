import 'dart:async';

import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/utils/result_state.dart';
import 'package:flutter/material.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({@required this.apiService}) {
    _fetchAllRestaurant();
  }

  RestaurantsResult _restaurantsResult;
  String _message = '';
  ResultState _state;

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.list();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Terjadi Kesalan, Mohon Periksa Koneksi Internet Anda';
    }
  }
}
