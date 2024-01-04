import 'package:flutter/material.dart';

extension ConnectionStateX on ConnectionState {
  bool get isLoading => this == ConnectionState.waiting;
}
