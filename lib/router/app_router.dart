import 'package:find_resto/presentation/detail/restaurant_detail_screen.dart';
import 'package:find_resto/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.route:
        return _pageRoute(HomeScreen());
        break;
      case RestaurantDetailScreen.route:
        final restaurantId = routeSettings.arguments as int;
        return _pageRoute(RestaurantDetailScreen(restaurantId: restaurantId));
        break;
      default:
        return _pageRoute(HomeScreen());
    }
  }

  static MaterialPageRoute _pageRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }
}
