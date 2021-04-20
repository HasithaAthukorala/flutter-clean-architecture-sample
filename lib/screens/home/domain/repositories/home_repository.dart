import 'package:dartz/dartz.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, bool>> logoutUser(String token);
}
