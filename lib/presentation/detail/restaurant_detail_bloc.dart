import 'package:find_resto/base/base_bloc.dart';
import 'package:find_resto/base/state_converter.dart';
import 'package:find_resto/data/repositories/restaurant_repository_impl.dart';
import 'package:find_resto/domain/entities/restaurant_entity.dart';
import 'package:rxdart/rxdart.dart';

class RestaurantDetailBloc extends BaseBloc {
  final _repository = RestaurantRepositoryImpl();

  final _restaurant = BehaviorSubject<StateConverter<RestaurantEntity>>();

  Stream<StateConverter<RestaurantEntity>> get restaurantStream => _restaurant.stream;

  final _isCollapseAppBar = BehaviorSubject<bool>();
  Stream<bool> get isCollapseAppBar => _isCollapseAppBar.stream;

  void setIsCollapseAppBar(bool isCollapseAppBar) {
    _isCollapseAppBar.sink.add(isCollapseAppBar);
  }

  setRestaurantDetailState({
    bool isLoading = false,
    RestaurantEntity restaurant,
  }) {
    _restaurant.sink.add(StateConverter(isLoading: isLoading, data: restaurant));
  }

  void getRestaurantById(int restaurantId) {
    setRestaurantDetailState(isLoading: true);
    _repository.getRestaurantById(restaurantId).then((restaurant) {
      setRestaurantDetailState(isLoading: false, restaurant: restaurant);
    });
  }

  @override
  void dispose() {
    _restaurant.close();
    _isCollapseAppBar.close();
  }
}
