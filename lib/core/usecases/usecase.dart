import 'package:fpdart/fpdart.dart';

/// Base usecase interface
abstract class UseCase<T, Params> {
  Future<Either<dynamic, T>> call(Params params);
}

/// Base usecase with no parameters
abstract class UseCaseNoParams<T> {
  Future<Either<dynamic, T>> call();
}

/// No parameters class for usecases that don't need parameters
class NoParams {
  const NoParams();
}
