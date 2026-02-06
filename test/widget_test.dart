// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:blabla/model/ride/locations.dart';
import 'package:blabla/services/rides_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:blablacar/main.dart';

void main() {
  RidesService.filterBy( 
departure: Location(name: "Dijon", country: Country.france), 
seatsRequested:2 
); 
}
