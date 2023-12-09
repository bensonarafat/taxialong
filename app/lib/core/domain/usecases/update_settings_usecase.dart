import 'package:dartz/dartz.dart';

import 'package:taxialong/core/domain/entities/settings_update_entity.dart';
import 'package:taxialong/core/domain/repositories/settings_repository.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';

class UpdateSettingsUseCase
    implements UseCase<SettingsUpdateEntity, SettingsParams> {
  SettingsRepository repository;

  UpdateSettingsUseCase({required this.repository});
  @override
  Future<Either<Failure, SettingsUpdateEntity>> call(
      SettingsParams params) async {
    return await repository.updateSettings(params);
  }
}

class SettingsParams {
  List<dynamic>? selectedClass;
  String paymentMethod;
  String? pointa;
  String? pointb;

  SettingsParams(
      {required this.selectedClass,
      required this.paymentMethod,
      required this.pointa,
      required this.pointb});
}
