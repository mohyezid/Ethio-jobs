part of 'api_bloc_bloc.dart';

@immutable
abstract class ApiBlocState {}

class ApiBlocInitial extends ApiBlocState {}

class ApiSearchProgress extends ApiBlocState {}

class ApiSearchsuccess extends ApiBlocState {
  final List<JobModal> jobs;

  ApiSearchsuccess({required this.jobs});
}

class ApiSearchFailure extends ApiBlocState {
  final String error;

  ApiSearchFailure({required this.error});
}
