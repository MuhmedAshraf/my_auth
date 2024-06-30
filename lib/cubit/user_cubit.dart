import 'package:my_auth/core/api/end_points.dart';
import 'package:my_auth/core/errors/exceptions.dart';
import 'package:my_auth/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_auth/models/signIn_model.dart';
import 'package:my_auth/models/signUp_model.dart';

import '../core/api/api_consumer.dart';

class UserCubit extends Cubit<UserState> {
  final ApiConsumer api;

  UserCubit({required this.api}) : super(UserInitial());

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

  signIn() async {
    try {
      emit(SignInLoading());
      final response = await api.post(
        EndPoint.signIn,
        data: {
          ApiKeys.email: signInEmail.text,
          ApiKeys.password: signInPassword.text,
        },
      );
      emit(SignInSuccess());
    } on ServerException catch (e) {
      emit(SignInFailure(errMessage: e.errorModel.errorMessage));
    }
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  signUp() async {
    emit(SignUpLoading());
    try {
      final response = await api.post(
        EndPoint.signUp,
        isFormData: true,
        data: {
          ApiKeys.name : signUpName.text,
          ApiKeys.email: signUpEmail.text,
          ApiKeys.password: signUpPassword.text,
          ApiKeys.phone: signUpPhoneNumber.text,
          ApiKeys.confirmPassword: confirmPassword.text,
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKeys.profilePic: await uploadProfilePic(profilePic!),
        },
      );
      final SignUpModel signUpModel = SignUpModel.fromJson(response);
      emit(SignUpSuccess(message: signUpModel.message));
    } on ServerException catch (e) {
    emit(SignUpFailure(errMessage: e.errorModel.errorMessage));
    }
  }
}
