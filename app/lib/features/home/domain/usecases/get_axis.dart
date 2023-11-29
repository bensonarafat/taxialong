import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';
import 'package:taxialong/features/home/domain/repositories/home_repository.dart';

class GetAxisUseCase extends UseCase<List<AxisEntity>, PositionParams> {
  final HomeRepository repository;
  GetAxisUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AxisEntity>>> call(PositionParams params) async {
    return await repository.getAxis(params: params);
  }
}

class PositionParams extends Equatable {
  final String? latitude;
  final String? longitude;
  const PositionParams({
    required this.latitude,
    required this.longitude,
  });
  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
