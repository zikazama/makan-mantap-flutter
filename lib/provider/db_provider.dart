import 'package:flutter/foundation.dart';
import 'package:dicoding_news_app/data/db/db_helper.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Data Tidak Ada';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant article) async {
    try {
      await databaseHelper.insertFavorite(article);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      print(_message);
    }
    notifyListeners();
  }

  Future<bool> isFavorited(String url) async {
    final bookmarkedArticle = await databaseHelper.getFavoriteById(url);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeFavorite(String url) async {
    try {
      await databaseHelper.removeFavorite(url);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
    }
    notifyListeners();
  }
}
