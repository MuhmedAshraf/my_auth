import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auth/cubit/user_cubit.dart';
import 'package:my_auth/cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    bool isProfileImage = false;
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state is UserDataLoading ? const CircularProgressIndicator() :
                state is UserDataSuccess ?
            ListView(
              children: [
                const SizedBox(height: 16),
                //! Profile Picture
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(state.user.profilePic ==null ? "": state.user.profilePic! ),
                ),
                const SizedBox(height: 16),

                //! Name
                 ListTile(
                  title: Text(state.user.name),
                  leading: const Icon(Icons.person),
                ),
                const SizedBox(height: 16),

                //! Email
                 ListTile(
                  title: Text(state.user.email),
                  leading: const Icon(Icons.email),
                ),
                const SizedBox(height: 16),

                //! Phone number
                 ListTile(
                  title: Text(state.user.phone),
                  leading: const Icon(Icons.phone),
                ),
                const SizedBox(height: 16),

                //! Address
                 ListTile(
                  title: Text(state.user.address['type']),
                  leading: Icon(Icons.location_city),
                ),
                const SizedBox(height: 16),
              ],
            ):  Container(),
          );
        },
      ),
    );
  }
}
