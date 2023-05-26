// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class MobileNumberSuccess extends AuthenticationState {
  String number;

  MobileNumberSuccess(this.number);

  @override
  List<Object> get props => [number];
}

class MobileNumberSubmitted extends AuthenticationState {}

class MobileNumberError extends AuthenticationState {
  String message;

  MobileNumberError(this.message);

  @override
  List<Object> get props => [message];
}

class OtpSubmitted extends AuthenticationState {}

class OtpSuccess extends AuthenticationState {
  VerifyOtpResponseModel verifyOtpResponseModel;

  OtpSuccess(this.verifyOtpResponseModel);

  OtpSuccess copyWith({
    VerifyOtpResponseModel? verifyOtpResponseModel,
  }) {
    return OtpSuccess(
      verifyOtpResponseModel ?? this.verifyOtpResponseModel,
    );
  }

  @override
  List<Object> get props => [verifyOtpResponseModel];
}

class OtpError extends AuthenticationState {
  String message;

  OtpError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileExists extends AuthenticationState{}

class ProfileNotExists extends AuthenticationState{}