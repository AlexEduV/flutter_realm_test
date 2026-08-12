import 'package:test_flutter_project/domain/services/time_service.dart';

class TimeServiceImpl implements TimeService {
  @override
  DateTime now() => DateTime.now();
}
