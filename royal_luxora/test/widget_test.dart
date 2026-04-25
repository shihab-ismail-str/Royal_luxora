import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:royal_luxora/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RoyalLuxoraApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}