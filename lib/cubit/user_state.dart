import '../models/user_model.dart';

class UserState {}

class UserInitial extends UserState {}

class SignInLoading extends UserState {}

class SignInSuccess extends UserState {
  final String message;

  SignInSuccess({required this.message});
}

class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}
//-**-***-*-*--*-*-*-*-*-*-*-**--*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*--*-*-*

class SignUpLoading extends UserState {}

class SignUpSuccess extends UserState {
  final String message;

  SignUpSuccess({required this.message});
}

class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

//-**-***-*-*--*-*-*-*-*-*-*-**--*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*--*-*-*

class UploadProfilePic extends UserState {}

//-**-***-*-*--*-*-*-*-*-*-*-**--*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*--*-*-*
class UserDataLoading extends UserState {}

class UserDataSuccess extends UserState {
  final UserModel user;

  UserDataSuccess({required this.user});
}

class UserDataFailure extends UserState {
  final String errMessage;

  UserDataFailure({required this.errMessage});
}

//-**-***-*-*--*-*-*-*-*-*-*-**--*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*--*-*-*
class UpdateLoading extends UserState {}

class UpdateSuccess extends UserState {
  final String message;

  UpdateSuccess({required this.message});
}

class UpdateFailure extends UserState {
  final String errMessage;

  UpdateFailure({required this.errMessage});
}

//-**-***-*-*--*-*-*-*-*-*-*-**--*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*--*-*-*
class LogOutLoading extends UserState {}

class LogOutSuccess extends UserState {
  final String message;

  LogOutSuccess({required this.message});
}

class LogOutFailure extends UserState {
  final String errMessage;

  LogOutFailure({required this.errMessage});
}

//-**-***-*-*--*-*-*-*-*-*-*-**--*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*--*-*-*
class DeleteLoading extends UserState{}
class DeleteSuccess extends UserState{
  final String message;

  DeleteSuccess({required this.message});
}
class DeleteFailure extends UserState{
  final String errMessage ;

  DeleteFailure({required this.errMessage});

}
