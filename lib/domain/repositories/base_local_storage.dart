import 'package:realm/realm.dart';

abstract class BaseLocalStorage {
  dynamic getAll<T>();

  void add(T);

  void deleteAll();

  void deleteById(ObjectId id);
}
