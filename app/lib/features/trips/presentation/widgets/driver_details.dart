import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:taxialong/core/utils/colors.dart';
import 'package:taxialong/core/widgets/taxi_along_cache_network_image.dart';
import 'package:taxialong/features/rides/domain/entities/driver_entity.dart';
import 'package:taxialong/features/rides/domain/entities/review_entity.dart';

class DriverDetails extends StatelessWidget {
  final DriverEntity driver;
  final List<ReviewEntity> reviews;
  const DriverDetails({
    super.key,
    required this.driver,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DriverWidget(driver: driver),
        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Information:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              Text(
                'Phone Number: ${driver.telephone}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Email: ${driver.email}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vehicle Details:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              Text(
                'Car Model: Toyota Corolla',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Car Plate Number: ABC 123 XY',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Car Colour: Yellow',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        //

        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'License Information:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              Text(
                "Driver's License Number:NGR-ABC-12345-XYZ",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Gap(18.h),
              Text(
                'Expiration Date: 31/12/2024',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),

        //

        Gap(8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.w, color: const Color(0xFF333333)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Reviews:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Gap(20.h),
              for (int i = 0; i < reviews.length; i++)
                Review(review: reviews[i]),
            ],
          ),
        ),
      ],
    );
  }
}

class Review extends StatelessWidget {
  final ReviewEntity review;
  const Review({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Passenger: ---- Rationship here ",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Gap(18.h),
        Text(
          'Rating: ${review.rating}/5',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Gap(18.h),
        Text(
          'Comment: ${review.comment}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class DriverWidget extends StatelessWidget {
  final DriverEntity driver;
  const DriverWidget({
    super.key,
    required this.driver,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: ShapeDecoration(
        color: const Color(0x19DADADA),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.w,
            color: const Color(0xFF333333),
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TaxiAlongCachedNetworkImage(
            path: driver.avatar,
            width: 50,
            height: 50,
            fit: BoxFit.fill,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: primaryColor,
              ),
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '${driver.firstname} ${driver.lastname}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Gap(4.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xffFFC700),
                            ),
                            Gap(4.w),
                            SizedBox(
                              width: 32.w,
                              child: Text(
                                driver.rating,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(32.w),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '10 min. away',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Gap(4.h),
                        Text(
                          '2, 5km',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
