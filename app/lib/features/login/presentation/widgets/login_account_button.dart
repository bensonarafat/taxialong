import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxialong/core/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_bottom_navigation.dart';

class LoginAccountButton extends StatelessWidget {
  const LoginAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBloc bottomNavigationBloc = BottomNavigationBloc();
    return Container(
      margin: EdgeInsets.only(
        top: 33.h,
      ),
      width: 358.w,
      height: 52.h,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(
                color: primaryColor,
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        ),
        child: Text(
          "Login",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: white,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => BlocProvider<BottomNavigationBloc>.value(
                value: bottomNavigationBloc,
                child: const TaxiAlongBottomNavigation(),
              ),
            ),
          );
        },
      ),
    );
  }
}
