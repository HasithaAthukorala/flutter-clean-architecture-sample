import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.networkInfo});

  @override
  Future<Either<Failure, bool>> logoutUser(String token) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.logoutUser(token);
        try {
          await localDataSource.clearToken();
          return Right(true);
        } on CacheException {
          return Left(CacheFailure());
        }
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoConnectionFailure());
    }
  }
}
