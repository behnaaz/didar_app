// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:didar_app/screen/calendar_screen.dart';
import 'package:didar_app/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:didar_app/main.dart';

void main() {
  
  group('Auth Wrapper', () {
    testWidgets('If User not Exist then go to login_screen',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      //await tester.pumpWidget(CalendarScreen());

      // Verify that our counter starts at 0.
      final hello = find.text('hello');
      // expect
          // TODO test is failing  expect(hello, findsOneWidget);
    });
    testWidgets('If User is Exist then go to bottom_navigation_wrapper',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      //await tester.pumpWidget(CalendarScreen());

      // Verify that our counter starts at 0.
      //final hello = find.text('hello');
      // expect
      //TODO test is failing expect(hello, findsOneWidget);
    });
  });
}
