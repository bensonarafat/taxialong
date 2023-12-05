import 'package:flutter/material.dart';
import 'package:taxialong/core/widgets/taxi_along_loading.dart';

class SettingsLoading extends StatelessWidget {
  const SettingsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 165, 165, 165),
        child: const Center(
          child: TaxiAlongLoading(),
        ),
      ),
    );
  }
}
