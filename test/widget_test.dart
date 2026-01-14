// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:storage_app/main.dart';

void main() {
  testWidgets('App loads with Log tab selected', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that Log screen is shown by default.
    // expect(find.text('Logger'), findsOneWidget);
    expect(find.text('Take Picture'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);
  });

  testWidgets('Navigation between tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Start on Log tab
    expect(find.text('Take Picture'), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt), findsOneWidget);

    // Navigate to Check tab
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();

    // Verify Check screen is shown
    expect(find.text('Check screen'), findsOneWidget);

    // Navigate to Settings tab
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    // Verify Settings screen is shown
    expect(find.text('Settings screen'), findsOneWidget);
  });

  testWidgets('Log screen has camera and gallery buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify buttons exist
    final takePictureButton = find.widgetWithText(
      ElevatedButton,
      'Take Picture',
    );
    final selectFromGalleryButton = find.widgetWithText(
      ElevatedButton,
      'Select from Gallery',
    );
    expect(takePictureButton, findsOneWidget);
    expect(selectFromGalleryButton, findsOneWidget);

    // Verify buttons are tappable (they won't do anything yet, but should not error)
    await tester.tap(takePictureButton);
    await tester.pump();

    await tester.tap(selectFromGalleryButton);
    await tester.pump();
  });

  testWidgets('Log screen displays "No image selected" initially', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify the "No image selected" text is displayed initially
    expect(find.text('No image selected'), findsOneWidget);
  });

  testWidgets('Log screen layout includes Column with buttons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify the main Column widget exists
    expect(find.byType(Column), findsWidgets);

    // Verify both buttons are present
    expect(find.widgetWithText(ElevatedButton, 'Take Picture'), findsOneWidget);
    expect(
      find.widgetWithText(ElevatedButton, 'Select from Gallery'),
      findsOneWidget,
    );

    // Verify Padding widget wraps the "No image selected" text
    expect(find.byType(Padding), findsWidgets);
  });

  testWidgets('Bottom navigation bar has all tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    // Verify all navigation destinations exist
    expect(find.text('Log'), findsNWidgets(2)); // AppBar + NavBar
    expect(find.text('Check'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Verify icons exist
    expect(find.byIcon(Icons.camera_alt), findsOneWidget); // Selected icon
    expect(find.byIcon(Icons.find_in_page_outlined), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
  });
}
