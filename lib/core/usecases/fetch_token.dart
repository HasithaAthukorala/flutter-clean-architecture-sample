import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/usecase.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/repositories/login_repository.dart';

class FetchToken implements UseCase<Login, TokenParams> {
  final LoginRepository repository;

  FetchToken({@required this.repository});

  @override
  Future<Either<Failure, Login>> call(TokenParams params) async {
    return await repository.fetchCachedToken();
  }
}

class TokenParams extends Equatable {}
