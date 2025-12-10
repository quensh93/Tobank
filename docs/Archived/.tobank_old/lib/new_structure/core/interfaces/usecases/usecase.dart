import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import '../../services/network/failures/app_failure/app_failure.dart';


abstract class UseCase<Type, Params> {
  Future<Either<AppFailure, Type>> call({required Params params});
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
