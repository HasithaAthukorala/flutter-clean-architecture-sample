import 'package:dartz/dartz.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
