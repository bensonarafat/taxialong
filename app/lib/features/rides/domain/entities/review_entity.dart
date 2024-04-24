class ReviewEntity {
  final int id;
  final int tripId;
  final int driverId;
  final int riderId;
  final String comment;
  final int rating;

  ReviewEntity(
      {required this.id,
      required this.tripId,
      required this.driverId,
      required this.riderId,
      required this.comment,
      required this.rating});
}
