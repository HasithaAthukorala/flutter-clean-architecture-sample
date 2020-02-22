import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/datasources/login_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/datasources/login_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, Login>> loginUser(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.loginUser(email, password);
        localDataSource.cacheToken(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Login>> fetchCachedToken() async {
    try {
      final localData = await localDataSource.getLastToken();
      return Right(localData);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
