import 'package:find_resto/data/datasources/restaurant_data_source.dart';
import 'package:find_resto/domain/entities/restaurant_entity.dart';
import 'package:find_resto/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl extends RestaurantRepository {
  final _dataSource = RestaurantDataSource();

  @override
  Future<List<RestaurantEntity>> searchRestaurant({String query = ''}) async {
    return _dataSource.searchRestaurant(query: query);
  }

  @override
  Future<RestaurantEntity> getRestaurantById(int restaurantId) async {
    return _dataSource.getRestaurantById(restaurantId);
  }
}
