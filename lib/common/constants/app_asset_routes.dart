class AppAssetRoutes {
  static const assetFolder = 'assets/';
  static const imagesFolder = 'images/';
  static const mocksFolder = 'mocks/';
  static const flagsFolder = 'country_flags/';
  static const envFolder = 'env/';

  static const flagRoute = '$assetFolder$imagesFolder$flagsFolder';

  static const yellowCarLoginBackground = '$assetFolder${imagesFolder}car-yellow.jpg';

  static const scaniaTruckBlackImage = '$assetFolder${imagesFolder}scania-black.jpg';
  static const hondaCivicRedImage = '$assetFolder${imagesFolder}honda-civic-red.jpg';
  static const porscheYellowImage = '$assetFolder${imagesFolder}porsche-yellow.jpeg';

  static const envRoute = '$assetFolder${envFolder}environment.env';

  static const errorImageRoute = '$assetFolder${imagesFolder}404-background.jpg';
}
