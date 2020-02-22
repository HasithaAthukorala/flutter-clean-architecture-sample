import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/usecase.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/repositories/change_password_repository.dart';

class ChangePassword extends UseCase<bool,ChangePasswordParams>{
  final ChangePasswordRepository repository;

  ChangePassword({this.repository});

  @override
  Future<Either<Failure, bool>> call(ChangePasswordParams params) {
    return repository.changePassword(params.oldPassword, params.newPassword);
  }
}

class ChangePasswordParams extends Equatable{
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams({@required this.oldPassword, @required this.newPassword});
}