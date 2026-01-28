import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';

import '../../common/extensions/car_scheme_extension.dart';
import '../models/scheme.dart';

class RealmLocalStorage implements BaseLocalStorage {
  final Realm realm;

  RealmLocalStorage(this.realm);

  @override
  void add(T) {
    realm.write(() {
      realm.add(CarExtensions.fromEntity(T));
    });
  }

  @override
  void update(T) {
    realm.write(() {
      realm.add(CarExtensions.fromEntity(T), update: true);
    });
  }

  @override
  Stream<List> watch<T>() {
    return realm.all<Car>().changes.map((changes) {
      return changes.results.map((schema) => schema.toEntity(schema)).toList();
    });
  }

  @override
  getAll() {
    return realm.all<Car>();
  }

  @override
  void deleteById(ObjectId id) {
    realm.write(() {
      final liveCar = realm.find<Car>(id);
      if (liveCar != null && liveCar.isValid) {
        realm.delete(liveCar);
      }
    });
  }

  @override
  void deleteAll() {
    realm.write(() {
      realm.deleteAll<Car>();
    });
  }
}
