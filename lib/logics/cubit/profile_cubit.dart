import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:login_frame_task/datas/repositories/profile_repository.dart';
import 'package:login_frame_task/logics/cubit/authentication_cubit.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthenticationCubit _authenticationCubit;
  final ProfileRepository _profileRepository = ProfileRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  ProfileCubit(this._authenticationCubit) : super(ProfileInitial());

  Future<void> onSubmitPressed() async {
    try {
      emit(ProfileSubmitted());
      var res = await _profileRepository.profileSubmit(
          token: _authenticationCubit.jwt ?? "",
          name: nameController.text,
          email: emailController.text);
      if (res != null) {
        emit(ProfileSuccess());
        _clearControllers;
      }
    } catch (e) {
      print(e);
      emit(ProfileError("Something went wrong"));
    }
  }

  void get _clearControllers {
    nameController.clear();
    emailController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    return super.close();
  }
}
