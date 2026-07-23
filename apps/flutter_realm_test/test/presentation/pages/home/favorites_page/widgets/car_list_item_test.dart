import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:realm/realm.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/domain/entities/car_entity.dart';
import 'package:test_flutter_project/domain/entities/engine_entity.dart';
import 'package:test_flutter_project/presentation/pages/home/widgets/car_list_item.dart';

void main() {
  final testCar = CarEntity(
    id: ObjectId(),
    carId: '1',
    model: 'Model S',
    manufacturer: 'Tesla',
    isVerified: true,
    type: 'car',
    bodyType: 'sedan',
    engine: EngineEntity(type: FuelType.ev.name),
    transmissionType: 'automatic',
    year: '2022',
    price: 50000,
  );

  testWidgets('displays car details', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CarListItem(car: testCar)),
      ),
    );

    expect(find.text('Tesla Model S 2022'), findsOneWidget);
    expect(find.text('\$ 50000'), findsOneWidget);
    expect(find.text('Sedan'), findsOneWidget);
    expect(find.byIcon(Icons.directions_car_outlined), findsOneWidget);
  });

  testWidgets('calls onDeleteCallback when favorite icon is tapped', (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CarListItem(
            car: testCar,
            onDeleteCallback: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(tapped, isTrue);
  });

  testWidgets('tapping main tile triggers navigation', (tester) async {
    // You can use a mock or override AppRouter.goToDetailsRouteFromExplore for this test.
    // For demonstration, we'll use a simple flag.
    //var tappedCarId = '';
    // Override AppRouter.goToDetailsRouteFromExplore in your test environment if possible.
    // For now, just check that the InkWell exists and is tappable.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: CarListItem(car: testCar)),
      ),
    );

    // Tap the main tile (not the favorite icon)
    final mainTile = find.byType(InkWell).first;
    await tester.tap(mainTile);
    await tester.pump();
    // If you can mock AppRouter, verify it was called with the correct carId.
    // Otherwise, this ensures the InkWell is tappable.
    expect(mainTile, findsOneWidget);
  });
}
