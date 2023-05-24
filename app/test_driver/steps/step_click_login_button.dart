import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

class ClickButton extends When1WithWorld<String, FlutterWorld> {
  @override
  Future<void> executeStep(String loginbtn) async {
// TODO: implement executeStep
    final loginfinder = find.byValueKey(loginbtn);
    await FlutterDriverUtils.tap(world.driver, loginfinder);
  }
  @override
  RegExp get pattern => RegExp(r"I tap the {string} button");
}