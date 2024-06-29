 class UserState {}
 class UserInitial extends UserState {}
 class SignInLoading extends UserState {}
 class SignInSuccess extends UserState {}
 class SignInFailure extends UserState {
 final String errMessage;

  SignInFailure({required this.errMessage});
 }
 //-**-***-*-*--*-*-*-*-*-*-*-**--*-*-*-*---*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--*-*-*-*--*-*-*

 class SignUpLoading extends UserState {}
 class SignUpSuccess extends UserState {}
 class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
 }
