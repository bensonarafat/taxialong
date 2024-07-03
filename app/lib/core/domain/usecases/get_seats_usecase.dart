import 'package:dartz/dartz.dart';
import 'package:taxialong/core/domain/entities/seats_entity.dart';
import 'package:taxialong/core/domain/repositories/settings_repository.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';

class GetSeatsUseCase implements UseCase<List<SeatsEntity>, void> {
  SettingsRepository repository;
  GetSeatsUseCase({required this.repository});
  @override
  Future<Either<Failure, List<SeatsEntity>>> call(void params) async {
    return await repository.getSeats();
  }
}
