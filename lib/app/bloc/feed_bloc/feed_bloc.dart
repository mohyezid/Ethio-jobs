import 'package:bloc/bloc.dart';
import 'package:job_search/app/api_handler/serach_api.dart';
import 'package:job_search/app/modals/JobModals.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc() : super(FeedInitial()) {
    on<FeedEvent>((event, emit) async {
      if (event is GetFeed) {
        emit(FeedInProgress());
        try {
          final res = await ApiHandler.searchAllJob();
          emit(FeedInSuccess(jobs: res));
        } catch (error) {
          print(error);
          emit(FeedInFailure());
        }
      }
      if (event is GetFilter) {
        emit(FeedInProgress());
        try {
          final res = await ApiHandler.searchqueryJob(event.search);
          emit(FeedInSuccess(jobs: res));
        } catch (error) {
          print(error);
          emit(FeedInFailure());
        }
      }
    });
  }
}
