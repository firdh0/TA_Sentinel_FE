// import 'dart:typed_data';

part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailed extends AuthState {
  final String e;
  const AuthFailed(this.e);

  @override
  // TODO: implement props
  List<Object> get props => [e];
}

class AuthCheckEmailSuccess extends AuthState {}

class AuthSuccess extends AuthState {

  final UserModel user;
  const AuthSuccess(this.user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

// class AuthStartSessionSuccess extends AuthState {
//   final String message;
//   const AuthStartSessionSuccess(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class AuthQRCodeReady extends AuthState {
//   final Uint8List imageBytes;
//   const AuthQRCodeReady(this.imageBytes);

//   @override
//   List<Object> get props => [imageBytes];
// }

// class AuthPhoneNumberFetched extends AuthState {
//   final String phoneNumber;
//   const AuthPhoneNumberFetched(this.phoneNumber);

//   @override
//   List<Object> get props => [phoneNumber];
// }