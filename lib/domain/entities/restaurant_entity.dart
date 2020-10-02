import 'package:find_resto/domain/entities/location_entity.dart';
import 'package:find_resto/domain/entities/rating_entity.dart';
import 'package:flutter/foundation.dart';

class RestaurantEntity {
  final String id;
  final String name;
  final String cuisines;
  final String thumbnailUrl;
  final String featuredImageUrl;
  final String timings;
  final String phoneNumbers;
  final String currency;
  final int priceRange;
  final List<String> highlights;
  final LocationEntity location;
  final RatingEntity userRating;

  RestaurantEntity({
    @required this.id,
    @required this.name,
    @required this.cuisines,
    @required this.thumbnailUrl,
    @required this.featuredImageUrl,
    @required this.timings,
    @required this.phoneNumbers,
    @required this.currency,
    @required this.priceRange,
    @required this.highlights,
    @required this.location,
    @required this.userRating,
  });

  String get priceFormatted {
    if (priceRange != null && priceRange == 0 && currency.isNotEmpty) {
      return '$currency $priceRange';
    } else {
      return 'Unknown';
    }
  }

  factory RestaurantEntity.fromJson(Map<String, dynamic> json) {
    return RestaurantEntity(
      id: json['id'] as String,
      name: json['name'] as String ?? '',
      cuisines: json['cuisines'] as String ?? '',
      thumbnailUrl: json['thumb'] as String ?? '',
      featuredImageUrl: json['featured_image'] as String ?? '',
      timings:  json['timings'] as String ?? '',
      phoneNumbers: json['phone_numbers'] as String ?? '',
      currency: json['currency'] as String ?? '',
      priceRange: json['price_range'] as int ?? 0,
      highlights: List<String>.from(json['highlights']),
      location: LocationEntity.fromJson(json['location']),
      userRating: RatingEntity.fromJson(json['user_rating']),
    );
  }
}
