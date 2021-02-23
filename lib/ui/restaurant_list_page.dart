import 'package:dicoding_news_app/provider/restaurant_provider.dart';
import 'package:dicoding_news_app/provider/restaurant_search_provider.dart';
import 'package:dicoding_news_app/ui/setting_page.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:dicoding_news_app/widgets/card_restaurant.dart';
import 'package:dicoding_news_app/ui/restaurant_search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_news_app/utils/result_state.dart';

import 'favorite_page.dart';

class RestaurantListPage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.count,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
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

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makan Mantap'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Provider.of<RestaurantSearchProvider>(context, listen: false)
                  .fetchSearchRestaurant('');
              Navigator.pushNamed(context, RestaurantSearchPage.routeName);
            },
          )
        ],
      ),
      body: _buildList(context),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 50, color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Favorite Restaurant'),
              onTap: () {
                Navigator.pushNamed(context, FavoritePage.routeName);
                print('Restaurant Favorite');
              },
            ),
            ListTile(
              title: Text('Setting'),
              onTap: () {
                Navigator.pushNamed(context, SettingPage.routeName);
                print('click setting');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Makan Mantap'),
        transitionBetweenRoutes: false,
        trailing: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RestaurantSearchPage.routeName);
          },
          child: Icon(
            CupertinoIcons.search,
            color: CupertinoColors.black,
          ),
        ),
      ),
      child: _buildList(context),
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
