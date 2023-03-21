import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_search/app/bloc/login_bloc/login_bloc.dart';
import 'package:job_search/app/screens/login/widgets/login_button.dart';
import 'package:job_search/app/screens/signup.dart';

import '../../../../core/constants.dart';
import 'custom_button.dart';

import 'fade_slide_transition.dart';

class LoginForm extends StatefulWidget {
  final Animation<double> animation;

  const LoginForm({
    required this.animation,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obscureText = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        children: <Widget>[
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LogInFailed) {
                return Text(
                  state.error,
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w300,
                      fontSize: 18),
                );
              }
              return Container();
            },
          ),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 0.0,

            // child: CustomInputField(
            //   txt: email,
            //   label: 'Username or Email',
            //   prefixIcon: Icons.person,
            // ),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(kPaddingM),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                hintText: "Username or Email",
                hintStyle: TextStyle(
                  color: kBlack.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: kBlack.withOpacity(0.5),
                ),
              ),
              obscureText: false,
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: space,
            // child: CustomInputField(
            //   txt: password,
            //   label: 'Password',
            //   prefixIcon: Icons.lock,
            //   show: true,
            // ),

            child: TextField(
              controller: password,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(kPaddingM),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.12)),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: kBlack.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: kBlack.withOpacity(0.5),
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: kBlack.withOpacity(0.5),
                ),
              ),
              obscureText: obscureText,
            ),
          ),
          SizedBox(height: space),
          FadeSlideTransition(
            animation: widget.animation,
            additionalOffset: 2 * space,
            child: LoginButton(
              color: kBlue,
              textColor: kWhite,
              text: 'Login to continue',
              onPressed: () {
                BlocProvider.of<LoginBloc>(context)
                    .add(Loginacc(email: email.text, pass: password.text));
              },
            ),
          ),
          SizedBox(height: 2 * space),
          // FadeSlideTransition(
          //   animation: widget.animation,
          //   additionalOffset: 3 * space,
          //   child: CustomButton(
          //     color: kWhite,
          //     textColor: kBlack.withOpacity(0.5),
          //     text: 'Continue with Google',
          //     image: const Image(
          //       image: AssetImage(kGoogleLogoPath),
          //       height: 48.0,
          //     ),
          //     onPressed: () {},
          //   ),
          // ),
          // SizedBox(height: space),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: FadeSlideTransition(
              animation: widget.animation,
              additionalOffset: 4 * space,
              child: CustomButton(
                color: kBlack,
                textColor: kWhite,
                text: 'Create a Ethio-Bestin Account',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return RegisterPage(title: "ABC");
                    },
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
