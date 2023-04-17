import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

void main(){
  final config = FlutterTestConfiguration()
    ..features = [Glob(r"test_driver/features/**.feature")]
    ..reporters = [
  ProgressReporter();
  TestRunSummaryReporter(),
  JsonReporter(path: './report.json')
  ]
  ..stepDefinitions = [
  NavigateToPageStep(),
  FillOutFormStep(),
  SaveChangesStep(),
  VerifyPageCreatedStep(),
  VerifyRedirectedStep(),
  VerifyRateEventButtonStep(),
  VerifyRatingsAndReviewsStep(),
  ]
  ..customStepParameterDefinitions=[ ]
  ..restartAppBeetweenScenarios = true
  ..targetAppPath