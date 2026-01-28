import 'package:realm/realm.dart';

abstract class BaseLocalStorage {
  dynamic getAll();

  void add(T);

  void update(T);

  Stream watch<T>();

  void deleteAll();

  void deleteById(ObjectId id);
}
