import 'package:find_resto/base/base_bloc.dart';
import 'package:find_resto/base/state_converter.dart';
import 'package:find_resto/data/repositories/restaurant_repository_impl.dart';
import 'package:find_resto/domain/entities/restaurant_entity.dart';
import 'package:rxdart/subjects.dart';

class RestaurantListBloc extends BaseBloc {

  final _repository = RestaurantRepositoryImpl();

  final _restaurants = BehaviorSubject<StateConverter<List<RestaurantEntity>>>();
  Stream<StateConverter<List<RestaurantEntity>>> get restaurantsStream => _restaurants.stream;

  void setRestaurantsState({
    bool isLoading = false,
    List<RestaurantEntity> data,
  }) {
    _restaurants.sink.add(StateConverter(isLoading: isLoading, data: data));
  }

  String _queryText = '';
  void setQueryText(String queryText) {
    _queryText = queryText;
  }

  void searchRestaurant() {
    setRestaurantsState(isLoading: true);
    _repository.searchRestaurant(query: _queryText).then((data) {
      setRestaurantsState(isLoading: false, data: data);
    });
  }

  @override
  void dispose() {
    _restaurants.close();
  }
}