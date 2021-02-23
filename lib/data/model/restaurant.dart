import 'dart:convert';

RestaurantsResult restaurantFromJson(String str) =>
    RestaurantsResult.fromJson(json.decode(str));

String restaurantToJson(RestaurantsResult data) => json.encode(data.toJson());

class RestaurantsResult {
  RestaurantsResult({
    this.error,
    this.message,
    this.count,
    this.founded,
    this.restaurants,
    this.restaurant,
  });

  bool error;
  String message;
  int count;
  int founded;
  List<Restaurant> restaurants;
  Restaurant restaurant;

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json["error"],
        message: json["message"],
        count: json.containsKey("count") ? json["count"] : null,
        founded: json.containsKey("founded") ? json["founded"] : null,
        restaurants: json.containsKey("restaurants")
            ? List<Restaurant>.from(
                json["restaurants"].map((x) => Restaurant.fromJson(x)))
            : null,
        restaurant: json.containsKey("restaurant")
            ? Restaurant.fromJson(json["restaurant"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.categories,
      this.menus,
      this.customerReviews});

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        categories: (json["categories"] != null || json["categories"] == '')
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : null,
        menus: (json["menus"] != null) ? Menus.fromJson(json["menus"]) : null,
        customerReviews: (json["customerReviews"] != null)
            ? List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "categories": categories != null
            ? List<dynamic>.from(categories.map((x) => x.toJson()))
            : null,
        "menus": menus != null ? menus.toJson() : null,
        "customerReviews": customerReviews != null
            ? List<dynamic>.from(customerReviews.map((x) => x.toJson()))
            : null,
      };
}

Restaurant restoFromJson(String str) => Restaurant.fromJson(json.decode(str));
String restoToJson(Restaurant data) => json.encode(data.toJson());

class Category {
  Category({
    this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
