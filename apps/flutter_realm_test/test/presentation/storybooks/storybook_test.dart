import 'package:flutter/cupertino.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_test/storybook_flutter_test.dart';
import 'package:test_futter_project/domain/entities/car_entity.dart';
import 'package:test_futter_project/domain/entities/user_entity.dart';
import 'package:test_futter_project/presentation/pages/details/widgets/owner_widget.dart';

void main() {
  final storyBook = Storybook(
    stories: [
      Story(
        name: 'Screens/Counter',
        description: 'Demo Counter app with about dialog.',
        builder: (context) => OwnerWidget(
          car: CarEntity.empty(),
          user: UserEntity.initial(
            userId: '1',
            firstName: 'Test',
            lastName: 'User',
            email: 'mock@gmail.com',
            password: 'test_pass',
          ),
        ),
      ),
      Story(
        name: 'Widgets/Text',
        description: 'Simple text widget.',
        builder: (context) => const Center(child: Text('Simple text')),
      ),
    ],
  );

  testStorybook(
    storyBook,
    layouts: [
      (device: Devices.ios.iPhone13, orientation: Orientation.portrait, isFrameVisible: true),
      (
        device: Devices.ios.iPadPro11Inches,
        orientation: Orientation.landscape,
        isFrameVisible: true,
      ),
      (
        device: Devices.android.samsungGalaxyA50,
        orientation: Orientation.portrait,
        isFrameVisible: true,
      ),
    ],
  );
}
