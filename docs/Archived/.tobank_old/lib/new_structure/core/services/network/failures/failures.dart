import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

// General server failure
class ServerFailure extends Failure {
  final dynamic response;

  const ServerFailure({this.response});

  @override
  List<Object?> get props => [response];
}