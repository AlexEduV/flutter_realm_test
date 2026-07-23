import 'package:realm/realm.dart';
import 'package:test_flutter_project/data/models/scheme.dart';

/// A hand-crafted fake for [Realm] that stores [Car] objects in memory.
///
/// Using @GenerateMocks([Realm]) is broken because Realm declares a `.dynamic`
/// getter that shadows Dart's `dynamic` keyword in generated code.
/// A real Realm instance cannot be opened in `flutter test` because the native
/// librealm_dart.dylib is not loaded in that context.
///
/// This fake implements [Realm] via noSuchMethod (so the `dynamic` getter is
/// never explicitly defined here) and only overrides the methods that
/// production code actually calls.
class FakeRealm implements Realm {
  final _cars = <Car>[];

  @override
  T write<T>(T Function() fn) => fn();

  @override
  T add<T extends RealmObject>(T object, {bool update = false}) {
    final car = object as Car;
    if (update) _cars.removeWhere((c) => c.id == car.id);
    _cars.add(car);
    return object;
  }

  @override
  RealmResults<T> all<T extends RealmObject>() =>
      _FakeRealmResults(List<T>.from(_cars));

  @override
  RealmResults<T> query<T extends RealmObject>(
    String query, [
    List<Object?> args = const [],
  ]) {
    if (query.contains('carId') && args.isNotEmpty) {
      final id = args[0] as String;
      final filtered = _cars.where((c) => c.carId == id).toList();
      return _FakeRealmResults(List<T>.from(filtered));
    }
    return _FakeRealmResults(List<T>.from(_cars));
  }

  @override
  void delete<T extends RealmObjectBase>(T object) {
    _cars.remove(object);
  }

  @override
  void deleteAll<T extends RealmObject>() => _cars.clear();

  @override
  // ignore: override_on_non_overriding_member
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeRealmResults<T extends RealmObject> implements RealmResults<T> {
  _FakeRealmResults(this._items);

  final List<T> _items;

  @override
  Iterator<T> get iterator => _items.iterator;

  @override
  int get length => _items.length;

  @override
  bool get isEmpty => _items.isEmpty;

  @override
  Iterable<E> map<E>(E Function(T) toElement) => _items.map(toElement);

  @override
  T get first => _items.first;

  @override
  // ignore: override_on_non_overriding_member
  dynamic noSuchMethod(Invocation invocation) => null;
}
