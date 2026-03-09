import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/models/owner_model.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/owner_widget.dart';
import 'package:test_futter_project/utils/l10n/l10n.dart';

void main() {
  setUp(() {
    // Set up localisations for the test
    AppLocalisations.localisations = {
      'pages.vehicleDetails.ownerSection.personTypeOwner': 'Owner',
      'widgets.distance.text': 'km away',
      'pages.vehicleDetails.ownerSection.contactButtonTitle': 'Contact',
    };
  });

  testWidgets('displays owner name, type, and distance', (WidgetTester tester) async {
    final car = CarEntity(
      carId: '1',
      model: 'Model S',
      manufacturer: 'Tesla',
      isVerified: true,
      type: 'Car',
      bodyType: 'sedan',
      fuelType: 'electric',
      transmissionType: 'automatic',
      owner: OwnerModel(id: 'test', name: 'Elon Musk', linkedItemIds: []),
      distanceTo: 42,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: OwnerWidget(car: car)),
      ),
    );

    // Owner name
    expect(find.text('Elon Musk'), findsOneWidget);

    // Owner type
    expect(find.text('Owner'), findsOneWidget);

    // Distance
    expect(find.text('42 km away'), findsOneWidget);

    // Contact button
    expect(find.widgetWithText(ElevatedButton, 'Contact'), findsOneWidget);
  });

  testWidgets('contact button can be tapped', (WidgetTester tester) async {
    //bool tapped = false;
    final car = CarEntity(
      carId: '1',
      model: 'Model S',
      manufacturer: 'Tesla',
      isVerified: true,
      type: 'Car',
      bodyType: 'sedan',
      fuelType: 'electric',
      transmissionType: 'automatic',
      owner: OwnerModel(id: 'test', name: 'Elon Musk', linkedItemIds: []),
      distanceTo: 42,
    );

    // Override OwnerWidget to inject a callback for testing
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => OwnerWidget(
              car: car,
              // You'd need to add an optional onContactPressed to OwnerWidget for this test
              // onContactPressed: () => tapped = true,
            ),
          ),
        ),
      ),
    );

    // Tap the button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Contact'));
    await tester.pump();

    // If you add a callback, you can check:
    // expect(tapped, isTrue);
    // Otherwise, just check the button exists and is tappable
    expect(find.widgetWithText(ElevatedButton, 'Contact'), findsOneWidget);
  });
}
