part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEmail extends AuthEvent{
  final String email;
  final String username;
  const AuthCheckEmail(this.email, this.username);

  @override
  // TODO: implement props
  List<Object> get props => [email, username];
}

class AuthRegister extends AuthEvent{
  final SignUpFormModel data;
  const AuthRegister(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class AuthLogin extends AuthEvent{
  final SignInFormModel data;
  const AuthLogin(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class AuthGetCurrentUser extends AuthEvent{}

class AuthUpdateUser extends AuthEvent{
  final UserEditFormModel data;
  const AuthUpdateUser(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

class AuthUpdatePin extends AuthEvent{
  final String oldPin;
  final String newPin;
  const AuthUpdatePin(this.oldPin, this.newPin);

  @override
  // TODO: implement props
  List<Object> get props => [oldPin, newPin];
}

class AuthUpdatePhoneNumber extends AuthEvent {
  final String phoneNumber;
  const AuthUpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

// class AuthStartSession extends AuthEvent {
//   final String sessionName;
//   const AuthStartSession(this.sessionName);

//   @override
//   List<Object> get props => [sessionName];
// }

// class AuthFetchQRCode extends AuthEvent {}

// class AuthFetchPhoneNumber extends AuthEvent {}

class AuthLogout extends AuthEvent{}