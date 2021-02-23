import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/provider/restaurant_detail_provider.dart';
import 'package:dicoding_news_app/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:provider/provider.dart';

final ApiService api = ApiService();

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: restaurant.pictureId == null
              ? Container(width: 100, child: Icon(Icons.error))
              : Hero(
                  tag: restaurant.name,
                  child: Image.network(
                    api.getPic(restaurant.pictureId),
                    width: 100,
                  ),
                ),
          title: Text(
            restaurant.name,
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.red,
                    size: 24.0,
                  ),
                  Text(restaurant.city),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 24.0,
                  ),
                  Text(restaurant.rating.toString()),
                ],
              ),
            ],
          ),
          onTap: () => {
                Provider.of<RestaurantDetailProvider>(context, listen: false)
                    .fetchDetailRestaurant(restaurant.id),
                Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.routeName,
                  arguments: restaurant,
                ),
              }),
    );
  }
}
