import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'dart:io';

class WaitApp extends When1WithWorld<int, FlutterWorld> {
  @override
  Future<void> executeStep(int time) async {
    sleep(Duration(seconds: time));
  }
  @override
  RegExp get pattern => RegExp(r"I wait {int} seconds");
}
