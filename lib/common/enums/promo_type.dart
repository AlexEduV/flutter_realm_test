enum PromoType { bestPrice, limitedTimeOffer, oneOwner, featured }

//todo: not very efficient to extend two functions when adding every next value
PromoType? promoTypeFromString(String? value) {
  switch (value) {
    case 'best_price':
      return PromoType.bestPrice;
    case 'one_owner':
      return PromoType.oneOwner;
    case 'limited_time_offer':
      return PromoType.limitedTimeOffer;
    case 'featured':
      return PromoType.featured;
    default:
      return null;
  }
}

//todo: add localisations here
String? stringFromPromoType(PromoType? value) {
  switch (value) {
    case PromoType.bestPrice:
      return 'Best Price';
    case PromoType.limitedTimeOffer:
      return 'Limited Time Offer';
    case PromoType.oneOwner:
      return 'One Owner';
    case PromoType.featured:
      return 'Featured';
    default:
      return null;
  }
}
