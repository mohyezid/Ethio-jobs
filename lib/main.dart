import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_search/app/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:job_search/app/bloc/login_bloc/login_bloc.dart';
import 'package:job_search/app/modals/JobModals.dart';
import 'package:job_search/app/screens/onboarding/onboarding.dart';
import 'package:job_search/core/data.dart';

import 'app/common/common.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Map<String, JobModal> storage = {};
  ProfileData data = ProfileData();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookmarkBloc(storage),
        ),
        BlocProvider(
          create: (context) => LoginBloc(data: data),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Common().appName,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        (() => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Hompage()))));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            // to do SplashScreen
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('images/logo_transparent.png'),
                ),
              ],
            )),
      ),
    );
  }
}

class Hompage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final screenHeight = MediaQuery.of(context).size.height;

        return Onboarding(screenHeight: screenHeight);
      },
    );
  }
}
