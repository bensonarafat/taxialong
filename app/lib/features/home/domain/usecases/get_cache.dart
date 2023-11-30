import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/home/domain/entities/axis_entity.dart';
import 'package:taxialong/features/home/domain/repositories/home_repository.dart';

class GetAxisCachedUseCase extends UseCase<List<AxisEntity>, bool> {
  final HomeRepository repository;
  GetAxisCachedUseCase({required this.repository});

  @override
  Future<Either<Failure, List<AxisEntity>>> call(bool params) async {
    return await repository.getAxisCached();
  }
}
