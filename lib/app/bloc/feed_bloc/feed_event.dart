part of 'feed_bloc.dart';

@immutable
abstract class FeedEvent {}

class GetFeed extends FeedEvent {}

class GetFilter extends FeedEvent {
  final String search;
  GetFilter({required this.search});
}
