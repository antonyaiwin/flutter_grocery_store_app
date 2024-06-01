import 'dart:developer';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
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

Future<Uint8List?> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      ?.buffer
      .asUint8List();
}
