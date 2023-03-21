part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkState {}

class BookmarkInitial extends BookmarkState {}

class BookmarkInprogress extends BookmarkState {}

class Bookmarksucced extends BookmarkState {
  final List<JobModal> jobs;
  Bookmarksucced({required this.jobs});
}

class BookmarkFailed extends BookmarkState {}
