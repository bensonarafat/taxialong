import 'package:flutter/cupertino.dart';
import 'package:taxialong/core/utils/colors.dart';

class TaxiAlongLoading extends StatelessWidget {
  final Color color;
  const TaxiAlongLoading({super.key, this.color = white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: color,
      ),
    );
  }
}
