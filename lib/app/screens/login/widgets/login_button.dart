import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_search/app/bloc/login_bloc/login_bloc.dart';

import '../../../../core/constants.dart';

class LoginButton extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final Widget? image;
  final VoidCallback onPressed;

  const LoginButton({
    required this.color,
    required this.textColor,
    required this.text,
    required this.onPressed,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
      ),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInProgress) {
            return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 0, 95, 173)),
            );
          }
          return image != null
              ? OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: kPaddingL),
                        child: image,
                      ),
                      Text(
                        text,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                )
              : TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: color,
                    padding: const EdgeInsets.all(kPaddingM),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: textColor, fontWeight: FontWeight.bold),
                  ),
                );
        },
      ),
    );
  }
}
