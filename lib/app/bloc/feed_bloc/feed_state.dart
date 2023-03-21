part of 'feed_bloc.dart';

@immutable
abstract class FeedState {}

class FeedInitial extends FeedState {}

class FeedInProgress extends FeedState {}

class FeedInSuccess extends FeedState {
  final List<JobModal> jobs;
  FeedInSuccess({required this.jobs});
}

class FeedInFailure extends FeedState {}
