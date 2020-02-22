import 'package:dartz/dartz.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, bool>> changePassword(String oldPassword, String newPassword);
}