import 'package:fpdart/fpdart.dart';

/// Base usecase interface
abstract class UseCase<Type, Params> {
  Future<Either<dynamic, Type>> call(Params params);
}

/// Base usecase with no parameters
abstract class UseCaseNoParams<Type> {
  Future<Either<dynamic, Type>> call();
}

/// No parameters class for usecases that don't need parameters
class NoParams {
  const NoParams();
}
