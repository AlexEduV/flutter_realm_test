import 'package:get_it/get_it.dart';

extension NotRegistered on GetIt {
  bool isNotRegistered<T extends Object>({Object? instance, String? instanceName, Type? type}) {
    return !isRegistered<T>(instance: instance, instanceName: instanceName, type: type);
  }
}
