import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:task_tracker_intern/main.dart';

void main() {
  testWidgets('Home screen renders welcome text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // The class name was updated from 'my' to 'MyApp' to match the main file.
    await tester.pumpWidget(const MyApp());

    // Wait for all animations and asynchronous processes to settle.
    await tester.pumpAndSettle();

    // Verify that the "Welcome," text is on the screen, indicating the home screen loaded successfully.
    expect(find.text('Welcome,'), findsOneWidget);

    // Verify that "My Task" is also on the screen.
    expect(find.text('My Task'), findsOneWidget);
  });
}
