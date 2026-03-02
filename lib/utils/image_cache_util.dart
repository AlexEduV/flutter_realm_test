import 'package:flutter/cupertino.dart' show PaintingBinding;

class ImageCacheUtil {
  static void initExtendedCacheSize() {
    PaintingBinding.instance.imageCache.maximumSize = 1000; // The default is a 100
    PaintingBinding.instance.imageCache.maximumSizeBytes =
        200 << 20; // 200 Mb, instead of a default 100 Mb
  }
}
