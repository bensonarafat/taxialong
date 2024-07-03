import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TaxiAlongCachedNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const TaxiAlongCachedNetworkImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return ClipOval(
        child: Image.asset(
          "assets/images/loading.gif",
          width: width,
          height: height,
        ),
      );
    } else {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: url!,
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) =>
              Image.asset("assets/images/loading.gif"),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    }
  }
}
