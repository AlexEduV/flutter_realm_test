import 'package:realm/realm.dart';
import 'package:test_futter_project/domain/repositories/base_local_storage.dart';

import '../common/extensions/car_scheme_extension.dart';

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
  void deleteAll() {
    // TODO: implement deleteAll
  }

  @override
  void deleteById(ObjectId id) {
    // TODO: implement deleteById
  }

  @override
  getAll<T>() {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
