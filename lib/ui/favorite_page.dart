import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/provider/db_provider.dart';
import 'package:dicoding_news_app/utils/result_state.dart';
import 'package:dicoding_news_app/widgets/card_restaurant.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: _listRestaurant(),
    );
  }

  Widget _listRestaurant() {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          final List<Restaurant> listResto = state.favorites;
          print(listResto);
          return ListView.builder(
            itemCount: listResto.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: listResto[index]);
            },
          );
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
}
