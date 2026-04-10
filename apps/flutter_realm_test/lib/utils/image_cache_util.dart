import 'package:flutter/cupertino.dart' show PaintingBinding;

/// A utility class for configuring Flutter's in-memory image cache.
///
/// By default, Flutter's [ImageCache] holds up to 100 images or 100 MB of image data
/// in memory. This class provides a method to increase these limits, which can be
/// useful for image-heavy applications to reduce image reloading and improve performance.
///
/// Example usage:
/// ```dart
/// void main() {
///   ImageCacheUtil.initExtendedCacheSize();
///   runApp(MyApp());
/// }
/// ```
class ImageCacheUtil {
  static void initExtendedCacheSize() {
    const cacheMaxSizeMb = 150;

    //default is 100 Mb;
    PaintingBinding.instance.imageCache.maximumSizeBytes = cacheMaxSizeMb << 20;
  }
}
