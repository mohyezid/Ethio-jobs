import 'package:bloc/bloc.dart';
import 'package:job_search/app/modals/JobModals.dart';
import 'package:meta/meta.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  Map<String, JobModal> list;
  BookmarkBloc(this.list) : super(BookmarkInitial()) {
    on<BookmarkEvent>((event, emit) {
      if (event is BookmarkAdded) {
        emit(BookmarkInprogress());
        list[event.job.jobId!] = event.job;
        if (list.values.toList().isEmpty) {
          emit(BookmarkFailed());
        } else {
          emit(Bookmarksucced(jobs: list.values.toList()));
        }
      }
      if (event is BookmarkRemoved) {
        emit(BookmarkInprogress());
        list.remove(event.id);
        if (list.values.toList().isEmpty) {
          emit(BookmarkFailed());
        } else {
          emit(Bookmarksucced(jobs: list.values.toList()));
        }
      }
    });
  }
}
