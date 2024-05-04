import 'package:bloc/bloc.dart';
import 'package:chat_armor/models/sign_in_form_model.dart';
import 'package:chat_armor/models/sign_up_form_model.dart';
import 'package:chat_armor/models/user_edit_form_model.dart';
import 'package:chat_armor/models/user_model.dart';
import 'package:chat_armor/services/auth_service.dart';
import 'package:chat_armor/services/pin_service.dart';
import 'package:chat_armor/services/user_service.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // TODO: implement event handler

      if(event is AuthCheckEmail){
        try {
          emit(AuthLoading());

          final res = await AuthService().checkEmail(event.email);

          if (res == false) {
            emit(AuthCheckEmailSuccess());
          } else {
            emit(const AuthFailed('Email telah terpakai'));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthRegister) {
        try {
          print('auth form register');

          emit(AuthLoading());

          final user = await AuthService().register(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          print(e.toString());
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          print('auth form login');

          emit(AuthLoading());

          final user = await AuthService().login(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          print(e.toString());
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final SignInFormModel res = await AuthService().getCredentialFromLocal();

          final UserModel user = await AuthService().login(res);

          print('Yeay sini berhasil');

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateUser) {
        try {
          if (state is AuthSuccess) {
            final updatedUser = (state as AuthSuccess).user.copyWith(
              username: event.data.username,
              name: event.data.name,
              email: event.data.email,
              password: event.data.password,
            );

            emit(AuthLoading());
            await UserService().updatedUser(event.data);
            emit(AuthSuccess(updatedUser));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdatePin) {
        try {
          if (state is AuthSuccess) {
            final updatedUser = (state as AuthSuccess).user.copyWith(
              pin: event.newPin
            );

            emit(AuthLoading());
            await PinService().updatePin(event.oldPin, event.newPin);
            emit(AuthSuccess(updatedUser));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogout) {
        try {
          emit(AuthLoading());

          await AuthService().logout();

          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
