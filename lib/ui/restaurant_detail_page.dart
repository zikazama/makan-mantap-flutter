import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/provider/db_provider.dart';
import 'package:dicoding_news_app/provider/restaurant_detail_provider.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:dicoding_news_app/widgets/card_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_news_app/utils/result_state.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({@required this.restaurant});

  Widget _buildDetail(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          var restaurant = state.result.restaurant;
          return CardDetail(restaurant: restaurant);
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makan Mantap'),
        actions: <Widget>[
          Consumer<DatabaseProvider>(builder: (context, dbProv, _) {
            return FutureBuilder<bool>(
              future: dbProv.isFavorited(restaurant.id),
              builder: (context, snapshot) {
                var isFavorited = snapshot.data ?? false;
                return isFavorited
                    ? IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () => dbProv.removeFavorite(restaurant.id),
                      )
                    : IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () => {
                          //print(restaurant.toJson()),
                          dbProv.addFavorite(restaurant)
                        },
                      );
              },
            );
          })
        ],
      ),
      body: _buildDetail(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Makan Mantap'),
        transitionBetweenRoutes: false,
      ),
      child: _buildDetail(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
