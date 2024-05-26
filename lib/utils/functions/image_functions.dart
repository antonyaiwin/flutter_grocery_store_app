import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List?> getCompressedImageData(
  Uint8List image, {
  int minWidth = 300,
  int minHeight = 300,
  int quality = 70,
}) async {
  var result = await FlutterImageCompress.compressWithList(
    image,
    minWidth: minWidth,
    minHeight: minHeight,
    quality: quality,
  );
  log(image.length.toString());
  log(result.length.toString());
  return result;
}
