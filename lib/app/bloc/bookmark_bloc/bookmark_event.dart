part of 'bookmark_bloc.dart';

@immutable
abstract class BookmarkEvent {}

class BookmarkAdded extends BookmarkEvent {
  final JobModal job;
  BookmarkAdded({required this.job});
}

class BookmarkRemoved extends BookmarkEvent {
  final String id;
  BookmarkRemoved({required this.id});
}
