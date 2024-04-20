import 'package:attendance_management_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:attendance_management_app/shared/providers/app_route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Onboarding screen widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: OnboardingScreen(),
        ),
      ),
    );

    // Verify that the OnboardingScreen widget renders correctly
    expect(find.byType(OnboardingScreen), findsOneWidget);

    // Verify that initial page index is 0
    expect(find.text('Effortlessly manage attendance with our intuitive app.'),
        findsOneWidget);

    // Swipe to the next page
    await tester.drag(find.byType(PageView), Offset(-400.0, 0.0));
    await tester.pumpAndSettle();

    // Verify that the page index has changed to 1
    expect(find.text('Secure and private data management'), findsOneWidget);

    // Swipe to the next page
    await tester.drag(find.byType(PageView), Offset(-400.0, 0.0));
    await tester.pumpAndSettle();

    // Verify that the page index has changed to 2
    expect(
        find.text('No more classroom roll calls. Attendance, just a tap away.'),
        findsOneWidget);
  });
}
