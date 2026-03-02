import 'package:flutter/cupertino.dart' show PaintingBinding;

class ImageCacheUtil {
  static void initExtendedCacheSize() {
    PaintingBinding.instance.imageCache.maximumSize = 1000;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 200 << 20; // 200 MB
  }
}
