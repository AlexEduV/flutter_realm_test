import 'package:flutter/cupertino.dart';
import 'package:test_flutter_project/domain/entities/user_entity.dart';

import '../../../../domain/entities/car_entity.dart';
import 'owner_widget.dart';

Widget buildOwnerWidgetUseCase(BuildContext context) {
  return OwnerWidget(
    car: CarEntity.empty(),
    user: UserEntity.initial(
      userId: '1',
      firstName: 'John',
      lastName: 'Smith',
      email: 'mock@email.com',
      password: 'pass',
    ),
  );
}
