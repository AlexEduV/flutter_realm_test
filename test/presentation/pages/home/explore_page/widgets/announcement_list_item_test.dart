import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/car_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/presentation/widgets/announcement_list_item.dart';
import 'package:test_futter_project/utils/l10n.dart';

void main() {
  setUp(() {
    AppLocalisations.localisations = {
      'actions.delete.title': 'Delete',
      'widgets.distance.text': 'km away',
    };
  });

  group('ExploreListItem', () {
    final car = CarEntity(
      carId: 'car123',
      model: 'Model S',
      manufacturer: 'Tesla',
      type: CarType.car.name,
      isVerified: true,
      hotPromotionDescription: 'Hot Promo',
      year: '2022',
      kilometers: 1000,
      distanceTo: 5,
      price: 90000,
      fuelType: FuelType.ev.name,
      bodyType: BodyType.sedan.name,
      transmissionType: TransmissionType.automatic.name,
    );

    final user = const UserEntity(
      userId: 'user1',
      firstName: 'John',
      lastName: 'Doe',
      isLocationPermissionGranted: true,
      favoriteIds: [],
    );

    testWidgets('displays car manufacturer, model, and year', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnnouncementListItem(car: car, user: user, onDismissed: () {}),
        ),
      );

      expect(find.text('TESLA MODEL S 2022'), findsOneWidget);
    });

    testWidgets('displays price and hot promotion icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnnouncementListItem(car: car, user: user, onDismissed: () {}),
        ),
      );

      final textWidgets = tester.widgetList<Text>(find.byType(Text));

      // Find the Text.rich widget with the price
      final priceTextWidget = textWidgets.firstWhere(
        (textWidget) =>
            textWidget.textSpan is TextSpan &&
            (textWidget.textSpan as TextSpan).toPlainText().contains('\$ 90000'),
      );

      expect(priceTextWidget, isNotNull);
      expect(find.byIcon(Icons.whatshot), findsOneWidget);
    });

    testWidgets('displays location info if permission granted', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnnouncementListItem(car: car, user: user, onDismissed: () {}),
        ),
      );

      final textWidgets = tester.widgetList<Text>(find.byType(Text));

      final distanceTextWidget = textWidgets.firstWhere(
        (textWidget) =>
            textWidget.textSpan is TextSpan &&
            (textWidget.textSpan as TextSpan).toPlainText().contains('5 km away'),
      );

      expect(find.byIcon(Icons.location_pin), findsOneWidget);
      expect(distanceTextWidget, isNotNull);
    });

    testWidgets('displays verified icon if car is verified', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnnouncementListItem(car: car, user: user, onDismissed: () {}),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('calls onDismissed when delete action is pressed', (WidgetTester tester) async {
      bool dismissed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: AnnouncementListItem(
            car: car,
            user: user,
            onDismissed: () {
              dismissed = true;
            },
          ),
        ),
      );

      await tester.pump();

      // Open the slidable
      final slidableFinder = find.byType(Slidable);
      expect(slidableFinder, findsOneWidget);

      await tester.drag(slidableFinder, const Offset(-300, 0));
      await tester.pumpAndSettle();

      final slidableActionFinder = find.byType(SlidableAction);
      expect(slidableActionFinder, findsOneWidget);

      // Tap the delete action
      await tester.tap(slidableActionFinder);
      await tester.pump();

      expect(dismissed, isTrue);
    });

    testWidgets('does not display location info if permission not granted', (
      WidgetTester tester,
    ) async {
      final userNoLocation = const UserEntity(
        userId: 'user2',
        firstName: 'Jane',
        lastName: 'Smith',
        isLocationPermissionGranted: false,
        favoriteIds: [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: AnnouncementListItem(car: car, user: userNoLocation, onDismissed: () {}),
        ),
      );

      expect(find.byIcon(Icons.location_pin), findsNothing);
      expect(find.text(' 5 km away'), findsNothing);
    });

    testWidgets('does not display verified icon if car is not verified', (
      WidgetTester tester,
    ) async {
      final carNotVerified = CarEntity(
        carId: 'car124',
        model: 'Model 3',
        manufacturer: 'Tesla',
        type: CarType.car.name,
        isVerified: false,
        year: '2021',
        kilometers: 500,
        distanceTo: 10,
        price: 50000,
        fuelType: FuelType.ev.name,
        bodyType: BodyType.sedan.name,
        transmissionType: TransmissionType.automatic.name,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: AnnouncementListItem(car: carNotVerified, user: user, onDismissed: () {}),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);
    });
  });
}
