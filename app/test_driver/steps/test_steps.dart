import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin/gherkin.dart';



StepDefinitionGeneric FillTextFieldStep() {
  return when2<String, String, FlutterWorld>(
    'the event organizer fills out the {string} field with {string}',
        (field, value, context) async {
      final locator = find.byValueKey(field);
      await FlutterDriverUtils.tap(context.world.driver, locator);
      await FlutterDriverUtils.enterText(context.world.driver, value);
      await FlutterDriverUtils.waitForFlutter(world.driver);
    },
  );
}

StepDefinitionGeneric TapButtonStep() {
  return when1<String, FlutterWorld>(
    'the event organizer taps the {string} button',
        (button, context) async {
      final locator = find.byValueKey(button);
      await FlutterDriverUtils.tap(context.world.driver, locator);
      await FlutterDriverUtils.waitForFlutter(world.driver);
    },
  );
}

StepDefinitionGeneric CheckTextStep() {
  return then1<String, FlutterWorld>(
    'the event organizer should see the text {string}',
        (text, context) async {
      final locator = find.text(text);
      expect(await FlutterDriverUtils.isPresent(context.world.driver, locator), true);
    },
  );
}

StepDefinitionGeneric CheckButtonStep() {
  return then1<String, FlutterWorld>(
    'the event organizer should see the {string} button',
        (button, context) async {
      final locator = find.byValueKey(button);
      expect(await FlutterDriverUtils.isPresent(context.world.driver, locator), true);
    },
  );
}

StepDefinitionGeneric CheckPageStep() {
  return then1<String, FlutterWorld>(
    'the event organizer should be on the {string} page',
        (page, context) async {
      final locator = find.byValueKey(page);
      expect(await FlutterDriverUtils.isPresent(context.world.driver, locator), true);
    },
  );
}

StepDefinitionGeneric CheckRatingStep() {
  return then1<String, FlutterWorld>(
    'the event organizer should see a {string} rating',
        (rating, context) async {
      final locator = find.byValueKey(rating);
      expect(await FlutterDriverUtils.isPresent(context.world.driver, locator), true);
    },
  );
}

StepDefinitionGeneric CheckReviewStep() {
  return then1<String, FlutterWorld>(
    'the event organizer should see the {string} review',
        (review, context) async {
      final locator = find.byValueKey(review);
      expect(await FlutterDriverUtils.isPresent(context.world.driver, locator), true);
    },
  );
}

StepDefinitionGeneric CheckRatingButtonStep() {
  return then1<String, FlutterWorld>(
    'the event page should include a {string} button for attendees to rate the event',
        (button, context) async {
      final locator = find.byValueKey(button);
      expect(await FlutterDriverUtils.isPresent(context.world.driver, locator), true);
    },
  );
}

StepDefinitionGeneric LoginStep() {
  return given2<String, String, FlutterWorld>(
    'the event organizer has an account on the app and is logged in',
        (email, password, context) async {
      final emailLocator = find.byValueKey('email_field');
      final passwordLocator = find.byValueKey('password_field');
      final loginButtonLocator = find.byValueKey('login_button');
      await FlutterDriverUtils.tap(context.world.driver, emailLocator);
      await FlutterDriverUtils.enterText(context.world.driver, emailLocator, email);
      await FlutterDriverUtils.tap(context.world.driver, passwordLocator);
      await FlutterDriverUtils.enterText(context.world.driver, passwordLocator, password);
      await FlutterDriverUtils.tap(context.world.driver, loginButtonLocator);
    },
  );
}

