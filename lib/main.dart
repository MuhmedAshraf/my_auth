import 'package:dio/dio.dart';
import 'package:my_auth/core/api/dio_consumer.dart';
import 'package:my_auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/user_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserCubit(api: DioConsumer(dio: Dio())),
      child: const Auth(),
    ),
  );
}

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
