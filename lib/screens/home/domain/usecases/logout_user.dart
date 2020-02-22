import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/usecase.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/repositories/home_repository.dart';

class LogOutUser implements UseCase<bool, LogOutParams> {
  final HomeRepository repository;

  LogOutUser({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(LogOutParams params) async {
    return await repository.logoutUser(params.token);
  }
}

class LogOutParams extends Equatable {
  final String token;
  LogOutParams({@required this.token}) : super([token]);
}
