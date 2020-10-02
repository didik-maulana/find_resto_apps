import 'dart:async';

import 'package:find_resto/domain/entities/restaurant_entity.dart';
import 'package:find_resto/network/network_manager.dart';

class RestaurantDataSource {
  final _network = NetworkManager();

  Future<List<RestaurantEntity>> searchRestaurant({String query = ''}) async {
    final response = await _network.request(
      path: 'search',
      parameters: {
        'q': query,
      },
    );

    final restaurants = response['restaurants']
        .map<RestaurantEntity>((json) => RestaurantEntity.fromJson(json['restaurant']))
        .toList(growable: false);
    return restaurants;
  }

  Future<RestaurantEntity> getRestaurantById(int restaurantId) async {
    final response = await _network.request(
      path: 'restaurant',
      parameters: {
        'res_id': '$restaurantId',
      },
    );
    final restaurant = RestaurantEntity.fromJson(response);
    return restaurant;
  }
}