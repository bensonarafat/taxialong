import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
      ),
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xff77787B),
        ),
      ),
      child: Row(
        children: [
          IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.search,
              size: 29.sp,
            ),
          ),
          Text(
            "Search for a route",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(0xffA0A2A9),
                ),
          ),
        ],
      ),
    );
  }
}
