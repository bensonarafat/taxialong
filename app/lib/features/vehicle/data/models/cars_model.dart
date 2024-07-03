import 'package:taxialong/features/vehicle/data/models/car_model.dart';
import 'package:taxialong/features/vehicle/domain/entities/cars_entity.dart';

class CarsModel extends CarsEntity {
  CarsModel(
      {required super.cars, required super.message, required super.status});

  factory CarsModel.fromJson(Map<String, dynamic> json) {
    List<CarModel>? cars;

    if (json['cars'] != null) {
      List<dynamic> jsonresponse = json['cars'];
      cars = jsonresponse.map((item) => CarModel.fromJson(item)).toList();
    }
    return CarsModel(
      cars: cars,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "cars": cars,
    };
  }
}
