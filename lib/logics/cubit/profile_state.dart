part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSubmitted extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class ProfileError extends ProfileState {
  String message;
  ProfileError(this.message);
  @override
  List<Object> get props => [message];
}
