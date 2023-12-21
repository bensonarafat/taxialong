import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/wallet/domain/entities/wallet_entity.dart';
import 'package:taxialong/features/wallet/domain/repositories/wallet_repository.dart';

class GetWalletUseCase extends UseCase<WalletEntity, void> {
  WalletRepository repository;
  GetWalletUseCase({required this.repository});
  @override
  Future<Either<Failure, WalletEntity>> call(void params) async {
    return await repository.getWallet();
  }
}
