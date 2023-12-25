import 'package:taxialong/features/rides/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.id,
    required super.tripId,
    required super.driverId,
    required super.riderId,
    required super.comment,
    required super.rating,
  });
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      tripId: json['trip_id'],
      driverId: json['driver_id'],
      riderId: json['rider_id'],
      comment: json['comment'],
      rating: json['rating'],
    );
  }
}
