import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Utils {
  static Future cacheImage(
          BuildContext context, String urlImage, String cacheKey) =>
      precacheImage(
          CachedNetworkImageProvider(urlImage, cacheKey: cacheKey), context);
}
