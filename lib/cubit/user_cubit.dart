import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_auth/cach/cache_helper.dart';
import 'package:my_auth/core/api/end_points.dart';
import 'package:my_auth/core/errors/exceptions.dart';
import 'package:my_auth/core/function/uploadImageToApi.dart';
import 'package:my_auth/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_auth/models/delete_user_model.dart';
import 'package:my_auth/models/logOut_model.dart';
import 'package:my_auth/models/signIn_model.dart';
import 'package:my_auth/models/signUp_model.dart';
import 'package:my_auth/models/update_model.dart';
import 'package:my_auth/models/user_model.dart';
import '../core/api/api_consumer.dart';
import '../repositories/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepo;

  UserCubit({required this.userRepo}) : super(UserInitial());

  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();

  //Sign in email
  TextEditingController signInEmail = TextEditingController();

  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  //Profile Pic
  XFile? profilePic;

  //Sign up name
  TextEditingController signUpName = TextEditingController();

  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();

  //Sign up email
  TextEditingController signUpEmail = TextEditingController();

  //Sign up password
  TextEditingController signUpPassword = TextEditingController();

  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  //update name
  TextEditingController newName = TextEditingController();

  //update Phone
  TextEditingController newPhone = TextEditingController();

  SignInModel? user;

  signIn() async {
    emit(SignInLoading());
    final response = await userRepo.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errorMessage) => emit(SignUpFailure(errMessage: errorMessage)),
      (signInModel) => emit(SignInSuccess(message: signInModel.message)),
    );
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  signUp() async {
    emit(SignUpLoading());
    final response = await userRepo.signUp(
      email: signUpEmail.text,
      password: signUpPassword.text,
      confirmPassword: confirmPassword.text,
      phone: signUpPhoneNumber.text,
      name: signUpName.text,
      profilePic: profilePic!,
    );
    response.fold(
      (errMessage) => emit(SignUpFailure(errMessage: errMessage)),
      (signUpModel) => emit(SignUpSuccess(message: signUpModel.message)),
    );
  }

  getUserData() async {
    emit(UserDataLoading());
    final response = await userRepo.getUserData();
    response.fold(
      (errMessage) => emit(UserDataFailure(errMessage: errMessage)),
      (userModel) => emit(UserDataSuccess(user: userModel)),
    );
  }

  updateUserInfo() async {
    emit(UpdateLoading());
    final response = await userRepo.updateUserInfo(
      newName: newName.text,
      newPhone: newPhone.text,
      profilePic: profilePic!,
    );
    response.fold(
      (errMessage) => emit(UpdateFailure(errMessage: errMessage)),
      (updateModel) => emit(UpdateSuccess(message: updateModel.message)),
    );
  }

  logOut() async {
    emit(LogOutLoading());
    final response = await userRepo.logOut();
    response.fold(
      (errMessage) => emit(LogOutFailure(errMessage: errMessage)),
      (updateModel) => emit(LogOutSuccess(message: updateModel.message)),
    );
  }

  deleteUser() async {
    emit(DeleteLoading());
    final response = await userRepo.deleteUser();
    response.fold(
          (errMessage) => emit(DeleteFailure(errMessage: errMessage)),
          (updateModel) => emit(DeleteSuccess(message: updateModel.message)),
    );
  }
}
