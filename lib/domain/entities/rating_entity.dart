import 'package:flutter/foundation.dart';

class RatingEntity {
  final String aggregateRating;
  final String ratingText;

  RatingEntity({
    @required this.aggregateRating,
    @required this.ratingText,
  });

  String get ratingFormatted {
    if (aggregateRating.isEmpty || aggregateRating == '0' || aggregateRating == '-') {
      return ratingText;
    } else {
      return '$aggregateRating - $ratingText';
    }
  }

  factory RatingEntity.fromJson(Map<String, dynamic> json) {
    return RatingEntity(
      aggregateRating: json['rating_obj']['title']['text'] as String ?? '',
      ratingText: json['rating_text'] as String ?? '',
    );
  }
}
