part of 'api_bloc_bloc.dart';

@immutable
abstract class ApiBlocEvent {}

class SearchJobs extends ApiBlocEvent {
  final String search;
  SearchJobs({required this.search});
}
