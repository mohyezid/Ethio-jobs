import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_search/app/bloc/login_bloc/login_bloc.dart';

import '../common/common.dart';
import '../common/widgets.dart';

class Profile extends StatefulWidget {
  final int prevScreen;

  Profile({
    Key? key,
    required this.prevScreen,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget textWidget(String text1, String text2) => Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text1,
                    style: GoogleFonts.lato(
                        color: Common().appColor, fontWeight: FontWeight.w600)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(text2,
                    style: GoogleFonts.lato(
                        color: Common().appColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300)),
              ),
            ],
          ),
        ),
      ));
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(body: SafeArea(
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LogInSuccess) {
                return Column(
                  children: [
                    Widgets().appBar(
                        context, "profile", widget.prevScreen, null, null),
                    Expanded(
                      child: Container(
                          child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: ListView(children: [
                          textWidget("Name", state.pdata.name!),
                          textWidget("Education",
                              "Addis Ababa Science and Technology University - AASTU"),
                          textWidget("Experience", state.pdata.experience!),
                          textWidget("Skills", state.pdata.skills!),
                          textWidget("Address", state.pdata.address!),
                          textWidget("Github", state.pdata.github!),

                          // Padding(
                          //   padding: const EdgeInsets.only(top: 50),
                          //   child: GestureDetector(
                          //     onTap: () {},
                          //     child: Container(
                          //       width: MediaQuery.of(context).size.width,
                          //       height: 40,
                          //       decoration: BoxDecoration(
                          //           color: Common().appColor,
                          //           borderRadius: BorderRadius.circular(10)),
                          //       child: Center(
                          //           child: Text("Edit",
                          //               style: GoogleFonts.lato(
                          //                   color: Common().white))),
                          //     ),
                          //   ),
                          // )
                        ]),
                      )),
                    ),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )),
        onWillPop: () async => false);
  }
}
