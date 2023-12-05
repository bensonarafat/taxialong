import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';

class TaxiAlongCachedNetworkImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final dynamic shape;
  final BoxFit fit;
  const TaxiAlongCachedNetworkImage({
    super.key,
    required this.path,
    required this.width,
    required this.height,
    required this.shape,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: shape,
      ),
      width: width.w,
      height: height.h,
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: path,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        placeholder: (context, url) => const TaxiAlongLoading(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
