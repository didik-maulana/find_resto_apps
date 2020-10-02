import 'package:find_resto/domain/entities/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<List<RestaurantEntity>> searchRestaurant({String query = ''});
  Future<RestaurantEntity> getRestaurantById(int restaurantId);
}