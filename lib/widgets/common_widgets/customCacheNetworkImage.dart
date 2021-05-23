import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:goodvibesoffl/utils/image_paths.dart';

class CustomCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxfit;
  final double height;
  final double width;
  final String placeholder;

  CustomCacheNetworkImage({
    @required this.imageUrl,
    this.boxfit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholder = placeholder_image,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: boxfit,
      width: width,
      height: height,
      cacheManager: CustomCacheManager.instance,
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
        fit: boxfit,
        width: width,
        height: height,
      ),
      placeholder: (context, url) => Image.asset(
        placeholder ?? placeholder_image,
        fit: boxfit,
        width: width,
        height: height,
      ),
      errorWidget: (context, url, error) => Image.asset(
        placeholder ?? placeholder_image,
        fit: boxfit,
        width: width,
        height: height,
      ),
    );
  }
}

class CustomCacheManager {
  static const key = 'libCachedImageData';

  static CacheManager instance = CacheManager(
    Config(
      key,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
      stalePeriod: Duration(days: 1),
    ),
  );
}

class ComposerCacheManager {
  static const key = 'composerImageCaching';

  static CacheManager instance = CacheManager(
    Config(
      key,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
      stalePeriod: Duration(days: 365),
    ),
  );
}
