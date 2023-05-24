import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:gherkin/gherkin.dart';

class WidgetPresentBeginning extends Given1WithWorld<String,FlutterWorld> {
@override
Future<void> executeStep(String input) async {

  final widget = find.byValueKey(input);
  bool inputExists = await FlutterDriverUtils.isPresent(world.driver, widget);
  expect(inputExists, true);
}
@override
// TODO: implement pattern
RegExp get pattern => RegExp(r"I see {string}");
}
