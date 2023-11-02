import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:rflutter_alert/rflutter_alert.dart';

double getCollapseOpacity(context) {
  final settings =
      context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
  final deltaExtent = settings.maxExtent - settings.minExtent;
  final t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
      .clamp(0.0, 1.0);
  final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
  const fadeEnd = 1.0;
  final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
  return opacity;
}

// Alert with multiple and custom buttons
onAlertButtonsPressed(context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "RFLUTTER ALERT",
    desc: "Flutter is more awesome with RFlutter Alert.",
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        color: const Color.fromRGBO(0, 179, 134, 1.0),
        child: const Text(
          "FLAT",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      DialogButton(
        onPressed: () => Navigator.pop(context),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0),
        ]),
        child: const Text(
          "GRADIENT",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )
    ],
  ).show();
}
