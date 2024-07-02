import 'package:flutter/material.dart';
import 'package:my_auth/screens/sign_in_screen.dart';
import 'package:my_auth/screens/sign_up_screen.dart';
import 'package:my_auth/widgets/custom_form_button.dart';
import 'package:my_auth/widgets/page_header.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 1,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            height: size.height * 0.5,
            width: double.infinity,
            child: PageHeader(image: "assets/images/welcome.png"),
          ),
          const Spacer(
            flex: 3,
          ),
          CustomFormButton(
              innerText: 'Log In',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              }),
          const SizedBox(
            height: 30,
          ),
          CustomFormButton(
              innerText: 'Sign Up',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()));
              }),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
