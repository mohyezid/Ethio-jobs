import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_search/app/bloc/login_bloc/login_bloc.dart';
import 'package:job_search/app/screens/home.dart';
import 'package:job_search/core/change_localization.dart';
import '../../../core/constants.dart';
import 'widgets/custom_clippers/index.dart';
import 'widgets/header.dart';
import 'widgets/login_form.dart';

class Login extends StatefulWidget {
  final double screenHeight;

  const Login({
    required this.screenHeight,
  });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _headerTextAnimation;
  late final Animation<double> _formElementAnimation;
  late final Animation<double> _whiteTopClipperAnimation;
  late final Animation<double> _blueTopClipperAnimation;
  late final Animation<double> _greyTopClipperAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _headerTextAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.0,
        0.6,
        curve: Curves.easeInOut,
      ),
    ));
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    final clipperOffsetTween = Tween<double>(
      begin: widget.screenHeight,
      end: 0.0,
    );
    _blueTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.2,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _greyTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.35,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );
    _whiteTopClipperAnimation = clipperOffsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeInOut,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        print(state);
        if (state is LogInSuccess) {
          return Home(title: 'Etio BestinJob', initialIndex: 0);
        }
        return Scaffold(
          backgroundColor: kWhite,
          body: Stack(
            children: <Widget>[
              AnimatedBuilder(
                animation: _whiteTopClipperAnimation,
                builder: (_, Widget? child) {
                  return ClipPath(
                    clipper: WhiteTopClipper(
                      yOffset: _whiteTopClipperAnimation.value,
                    ),
                    child: child,
                  );
                },
                child: Container(color: kGrey),
              ),
              AnimatedBuilder(
                animation: _greyTopClipperAnimation,
                builder: (_, Widget? child) {
                  return ClipPath(
                    clipper: GreyTopClipper(
                      yOffset: _greyTopClipperAnimation.value,
                    ),
                    child: child,
                  );
                },
                child: Container(color: kBlue),
              ),
              AnimatedBuilder(
                animation: _blueTopClipperAnimation,
                builder: (_, Widget? child) {
                  return ClipPath(
                    clipper: BlueTopClipper(
                      yOffset: _blueTopClipperAnimation.value,
                    ),
                    child: child,
                  );
                },
                child: Container(color: kWhite),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Header(animation: _headerTextAnimation),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("change_language".tr()),
                              Container(
                                color: Colors.white,
                                // Adjust the width according to your requirement
                                child: DropdownButton<String>(
                                  value: _selectedLanguage,
                                  icon: Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    if (value != _selectedLanguage) {
                                      ChangeLocalization.changeLanguage(
                                          context);
                                    }
                                    setState(() {
                                      _selectedLanguage = value!;
                                    });
                                  },
                                  items: <String>[
                                    'English',
                                    'አማርኛ'
                                  ] // Replace with your desired languages
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 210,
                        ),
                        LoginForm(animation: _formElementAnimation),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
