import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/common/enums/promo_type.dart';

void main() {
  group('PromoType', () {
    test('fromCode returns correct enum', () {
      expect(PromoType.fromCode('best_price'), PromoType.bestPrice);
      expect(PromoType.fromCode('limited_time_offer'), PromoType.limitedTimeOffer);
      expect(PromoType.fromCode('one_owner'), PromoType.oneOwner);
      expect(PromoType.fromCode('featured'), PromoType.featured);
      expect(PromoType.fromCode('unknown'), isNull);
      expect(PromoType.fromCode(null), isNull);
    });
  });
}
