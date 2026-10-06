import 'package:flutter_test/flutter_test.dart';

import 'package:with_me/main.dart';

void main() {
  testWidgets('app starts on splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('With Me'), findsOneWidget);
    expect(find.text('Your AI Companion'), findsOneWidget);
  });
}
