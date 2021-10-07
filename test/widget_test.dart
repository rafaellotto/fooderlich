import 'package:flutter_test/flutter_test.dart';
import 'package:fooderlich/fooderlich.dart';

void main() {
  testWidgets('Home page shows initial text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Fooderlich());

    expect(find.text("Let's get cooking 👩‍🍳"), findsOneWidget);
  });
}
