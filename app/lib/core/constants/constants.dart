import 'package:flutter/material.dart';
import 'package:onboarding_slider_flutter/onboarding_slider_flutter.dart';
import 'package:taxialong/core/constants/assets.dart';

///
/// App Constants
///

const endpoint = "http://taxialong.com/api/";

const LinearGradient onboardGradiant = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xff0a74d7),
    Color(0xff105DA5),
    Color(0xff144A7D),
    Color(0xff173B5D),
    Color(0xff1B2D3D),
    Color(0xff1D252E),
    Color(0xff1E1F1F),
  ],
);

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Choose your destination",
    description:
        "Find the perfect ride to take you where you need to go by selecting your drop-off location",
    image: onboardingCarousel1,
  ),
  const OnBoardModel(
    title: "Choose your level of comfort",
    description:
        "Select your preferred ride type and enjoy a personalized, stress-free ride that matches your comfort level.",
    image: onboardingCarousel2,
  ),
  const OnBoardModel(
    title: "Enjoy Your ride",
    description:
        "Sit back and relax while your driver takes you to your destination. With features like live tracking and in-app communication, you can enjoy a worry-free ride.",
    image: onboardingCarousel3,
  ),
];

const appSliverExpandedHeightFixture = 178.0;

List<String> busstops = [
  "Apo Junction",
  "Area 1 Junction",
  "Lokogoma Junction",
  "Garki Junction",
  "Lugbe Junction",
  "Wuye Junction",
  "Jabi Junction",
  "Asokoro Junction",
  "Apo Junction",
  "Area 1 Junction",
  "Lokogoma Junction",
  "Garki Junction",
  "Lugbe Junction",
  "Wuye Junction",
];
