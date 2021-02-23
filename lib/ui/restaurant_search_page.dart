import 'package:dicoding_news_app/provider/restaurant_search_provider.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:dicoding_news_app/widgets/card_restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:dicoding_news_app/utils/result_state.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search';

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void filterSearchResults(String query) async {
    return;
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (state.state == ResultState.HasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) async {
                      await Future.delayed(const Duration(seconds: 3));
                      Provider.of<RestaurantSearchProvider>(context,
                              listen: false)
                          .fetchSearchRestaurant(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                        labelText: "Search Restaurant",
                        hintText: "Restaurant Name",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.result.founded,
                    itemBuilder: (context, index) {
                      var restaurant = state.result.restaurants[index];
                      return CardRestaurant(restaurant: restaurant);
                    },
                  ),
                ),
              ],
            );
          } else if (state.state == ResultState.NoData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.Error) {
            return Center(child: Text('Mohon Periksa Koneksi Internet Anda'));
          } else {
            return Text('');
          }
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Makan Mantap'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Makan Mantap'),
        transitionBetweenRoutes: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
