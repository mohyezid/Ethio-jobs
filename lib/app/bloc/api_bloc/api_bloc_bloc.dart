import 'package:bloc/bloc.dart';
import 'package:job_search/app/api_handler/serach_api.dart';
import 'package:job_search/app/modals/JobModals.dart';
import 'package:meta/meta.dart';

part 'api_bloc_event.dart';
part 'api_bloc_state.dart';

class ApiBlocBloc extends Bloc<ApiBlocEvent, ApiBlocState> {
  ApiBlocBloc() : super(ApiBlocInitial()) {
    on<ApiBlocEvent>((event, emit) async {
      if (event is SearchJobs) {
        emit(ApiSearchProgress());
        print(event.search);
        if (event.search == '') {
          emit(ApiSearchFailure(error: 'no search entry'));
          return;
        }
        try {
          final res = await ApiHandler.searchqueryJob(event.search);
          emit(ApiSearchsuccess(jobs: res));
          print(res.length);
        } catch (error) {
          emit(ApiSearchFailure(error: 'server error'));
        }
      }
      // TODO: implement event handler
    });
  }
}
