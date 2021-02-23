import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';

final ApiService api = ApiService();

class CardDetail extends StatelessWidget {
  final Restaurant restaurant;

  const CardDetail({Key key, @required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Hero(
            tag: restaurant.name,
            child: Image.network(api.getPic(restaurant.pictureId))),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                restaurant.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.place,
                    color: Colors.red,
                    size: 24.0,
                  ),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              Divider(color: Colors.grey),
              Text(
                'Deskripsi',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 10),
              Text(
                restaurant.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Divider(color: Colors.grey),
              Text(
                'Makanan',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var item in restaurant.menus.foods)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '-' + item.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                ],
              ),
              Divider(color: Colors.grey),
              Text(
                'Minuman',
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var item in restaurant.menus.drinks)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '-' + item.name,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
