enum PromoType {
  //todo: add localisations in the second set;
  bestPrice('best_price', 'Best Price'),
  limitedTimeOffer('limited_time_offer', 'Limited Time Offer'),
  oneOwner('one_owner', 'One Owner'),
  featured('featured', 'Featured');

  final String code;
  final String localized;

  const PromoType(this.code, this.localized);

  static PromoType? fromCode(String? code) {
    if (code == null) return null;

    return PromoType.values.cast<PromoType?>().firstWhere(
      (e) => e?.code == code,
      orElse: () => null,
    );
  }
}
