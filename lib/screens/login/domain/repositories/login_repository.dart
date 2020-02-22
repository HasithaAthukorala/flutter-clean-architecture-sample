import 'package:dartz/dartz.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';

abstract class LoginRepository {
  Future<Either<Failure, Login>> loginUser(String email, String password);
  Future<Either<Failure, Login>> fetchCachedToken();
}
