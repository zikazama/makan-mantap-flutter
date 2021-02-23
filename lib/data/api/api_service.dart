import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dicoding_news_app/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _baseUrlPic =
      'https://restaurant-api.dicoding.dev/images/medium/';

  Future<RestaurantsResult> list() async {
    final response = await http.get(_baseUrl + "list");
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<RestaurantsResult> detail(id) async {
    final response = await http.get(_baseUrl + "detail/" + id);
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<RestaurantsResult> search(query) async {
    final response = await http.get(_baseUrl + "search?q=" + query);
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  String getPic(String id) {
    return _baseUrlPic + id;
  }
}
