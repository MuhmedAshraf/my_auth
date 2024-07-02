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

  //update name
  TextEditingController newName = TextEditingController();

  //update Phone
  TextEditingController newPhone = TextEditingController();

  SignInModel? user;

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
      user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user!.token);
      print(decodedToken['id']);
      emit(SignInSuccess(message: user!.message));
      CacheHelper().saveData(key: ApiKeys.token, value: user!.token);
      CacheHelper().saveData(key: ApiKeys.id, value: decodedToken[ApiKeys.id]);
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
          ApiKeys.name: signUpName.text,
          ApiKeys.email: signUpEmail.text,
          ApiKeys.password: signUpPassword.text,
          ApiKeys.phone: signUpPhoneNumber.text,
          ApiKeys.confirmPassword: confirmPassword.text,
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKeys.profilePic: await uploadImageToApi(profilePic!),
        },
      );
      final SignUpModel signUpModel = SignUpModel.fromJson(response);
      emit(SignUpSuccess(message: signUpModel.message));
    } on ServerException catch (e) {
      emit(SignUpFailure(errMessage: e.errorModel.errorMessage));
    }
  }

  getUserData() async {
    try {
      emit(UserDataLoading());
      final response = await api.get(
          EndPoint.getUserDataEndPoint(CacheHelper().getData(key: ApiKeys.id)));
      emit(
        UserDataSuccess(
          user: UserModel.fromJson(response),
        ),
      );
    } on ServerException catch (e) {
      emit(UserDataFailure(errMessage: e.errorModel.errorMessage));
    }
  }

  updateUserInfo() async {
    try {
      emit(UpdateLoading());
      final response = await api.patch(
        EndPoint.update,
        isFormData: true,
        data: {
          ApiKeys.name: newName.text.isEmpty
              ? CacheHelper().getData(key: ApiKeys.name)
              : newName.text,
          ApiKeys.phone: newPhone.text.isEmpty
              ? CacheHelper().getData(key: ApiKeys.id)
              : newPhone.text,
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKeys.profilePic: await uploadImageToApi(profilePic!),
        },
      );
      final UpdateModel updateModel = UpdateModel.fromJson(response);
      emit(UpdateSuccess(message: updateModel.message));
    } on ServerException catch (e) {
      emit(UpdateFailure(errMessage: e.errorModel.errorMessage));
    }
  }

  logOut()async{
    try {
      emit(LogOutLoading());
      final response = await api.get(EndPoint.logOut);
      LogOutModel logOutModel= LogOutModel.fromJson(response);
      emit(LogOutSuccess(message: logOutModel.message));
    } on ServerException catch (e) {
      emit(LogOutFailure(errMessage: e.errorModel.errorMessage));
    }
  }
  
  deleteUser()async{
    try {
      emit(DeleteLoading());
      final response = await api.delete(EndPoint.delete,queryParameters: {
        ApiKeys.id : CacheHelper().getData(key: ApiKeys.id)
      },);
      final DeleteModel deleteModel = DeleteModel.fromJson(response);
      emit(DeleteSuccess(message: deleteModel.message ));
    } on ServerException catch (e) {
     emit(DeleteFailure(errMessage: e.errorModel.errorMessage));
    }
  }
  
  
}
