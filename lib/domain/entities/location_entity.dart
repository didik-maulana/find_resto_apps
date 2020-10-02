import 'package:flutter/foundation.dart';

class LocationEntity {
  final String address;

  LocationEntity({@required this.address});

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      address: json['address'],
    );
  }
}
