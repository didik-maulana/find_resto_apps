import 'package:flutter/material.dart';

class StateConverter<T> {
  final bool isLoading;
  final T data;

  StateConverter({
    @required this.isLoading,
    @required this.data,
  });
}