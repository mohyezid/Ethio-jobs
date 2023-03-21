import 'package:bloc/bloc.dart';
import 'package:job_search/app/modals/Profiledata.dart';
import 'package:job_search/app/screens/profile.dart';
import 'package:job_search/core/data.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ProfileData data;
  LoginBloc({required this.data}) : super(LoginInitial()) {
    on<Loginacc>(loginuser);
    on<Signupacc>(signupUser);
    on<Logout>(logout);
  }
  Future<void> loginuser(Loginacc event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        if (event.email == '' || event.pass == '') {
          emit(LogInFailed(error: "Please all Information must be filled"));
        } else if (data.pdata.containsKey(event.email.trim()) &&
            data.pdata[event.email.trim()]!['password'] == event.pass.trim()) {
          emit(LogInSuccess(
              pdata: ProfileState.fromJson(data.pdata[event.email.trim()]!)));
        } else {
          emit(LogInFailed(error: 'wrong or invalid information'));
        }
      },
    );
  }

  Future<void> signupUser(Signupacc event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());
    await Future.delayed(
      const Duration(seconds: 1),
      () {
        if (event.email == '') {
          emit(LogInFailed(error: "Please all Information must be filled"));
        } else if (data.pdata.containsKey(event.email.trim())) {
          emit(LogInFailed(error: 'This email is already registered'));
        } else {
          data.setPdata(event.email, event.data);

          emit(LogInSuccess(
              pdata: ProfileState.fromJson(data.pdata[event.email.trim()]!)));
        }
      },
    );
  }

  void logout(Logout event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }
}
