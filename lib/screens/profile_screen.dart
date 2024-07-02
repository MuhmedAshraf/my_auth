import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_auth/cubit/user_cubit.dart';
import 'package:my_auth/cubit/user_state.dart';
import 'package:my_auth/screens/sign_in_screen.dart';
import 'package:my_auth/screens/sign_up_screen.dart';
import 'package:my_auth/screens/update_user_screen.dart';
import 'package:my_auth/screens/welcome_screen.dart';

import '../widgets/custom_form_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserDataFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
          if (state is LogOutSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          } else if (state is LogOutFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
          if(state is DeleteFailure){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          }else if(state is DeleteSuccess){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const WelcomeScreen()));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state is UserDataLoading
                ? const CircularProgressIndicator()
                : state is UserDataSuccess
                    ? ListView(
                        children: [
                          const SizedBox(height: 16),
                          //! Profile Picture
                          CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(
                                state.user.profilePic == null
                                    ? ""
                                    : state.user.profilePic!),
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
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomFormButton(
                              innerText: 'Update Info',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UpdateScreen()));
                              },
                            ),
                          ),
                          const SizedBox(height: 25),
                          state is LogOutLoading
                              ? const CircularProgressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: CustomFormButton(
                                    innerText: 'Log Out',
                                    onPressed: () {
                                      context.read<UserCubit>().logOut();
                                    },
                                  ),
                                ),
                          const SizedBox(height: 25),
                          state is DeleteLoading
                              ? const CircularProgressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: CustomFormButton(
                                    innerText: 'Delete My Account',
                                    onPressed: () {
                                      context.read<UserCubit>().deleteUser();
                                    },
                                  ),
                                ),
                        ],
                      )
                    : Container(),
          );
        },
      ),
    );
  }
}
