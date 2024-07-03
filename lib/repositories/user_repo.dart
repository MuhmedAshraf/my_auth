import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_auth/core/api/api_consumer.dart';
import 'package:my_auth/models/delete_user_model.dart';
import 'package:my_auth/models/signUp_model.dart';
import 'package:my_auth/models/update_model.dart';
import 'package:my_auth/models/user_model.dart';

import '../cach/cache_helper.dart';
import '../core/api/end_points.dart';
import '../core/errors/exceptions.dart';
import '../core/function/uploadImageToApi.dart';
import '../models/logOut_model.dart';
import '../models/signIn_model.dart';

class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});

  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoint.signIn,
        data: {
          ApiKeys.email: email,
          ApiKeys.password: password,
        },
      );
      final SignInModel user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      CacheHelper().saveData(key: ApiKeys.token, value: user.token);
      CacheHelper().saveData(key: ApiKeys.id, value: decodedToken[ApiKeys.id]);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required String name,
    required XFile profilePic,
  }) async {
    try {
      final response = await api.post(
        EndPoint.signUp,
        isFormData: true,
        data: {
          ApiKeys.name: name,
          ApiKeys.email: email,
          ApiKeys.password: password,
          ApiKeys.phone: phone,
          ApiKeys.confirmPassword: confirmPassword,
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKeys.profilePic: await uploadImageToApi(profilePic),
        },
      );
      final SignUpModel signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserData() async {
    try {
      final response = await api.get(
          EndPoint.getUserDataEndPoint(CacheHelper().getData(key: ApiKeys.id)));
      final UserModel user = UserModel.fromJson(response);
      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UpdateModel>> updateUserInfo({
    required String newName,
    required String newPhone,
    required XFile profilePic,
  }) async {
    try {
      final response = await api.patch(
        EndPoint.update,
        isFormData: true,
        data: {
          ApiKeys.name: newName.isEmpty
              ? CacheHelper().getData(key: ApiKeys.name)
              : newName,
          ApiKeys.phone: newPhone.isEmpty
              ? CacheHelper().getData(key: ApiKeys.id)
              : newPhone,
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
          ApiKeys.profilePic: await uploadImageToApi(profilePic),
        },
      );
      final UpdateModel updateModel = UpdateModel.fromJson(response);
      return Right(updateModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String,DeleteModel>> deleteUser()async{
    try {
      final response = await api.delete(
        EndPoint.delete,
        queryParameters: {ApiKeys.id: CacheHelper().getData(key: ApiKeys.id)},
      );
      final DeleteModel deleteModel = DeleteModel.fromJson(response);
      return Right(deleteModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String,LogOutModel>> logOut()async{
    try {
      final response = await api.get(EndPoint.logOut);
      LogOutModel logOutModel = LogOutModel.fromJson(response);
      return Right(logOutModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }

  }
}
