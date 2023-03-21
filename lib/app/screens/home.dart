import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_search/app/bloc/api_bloc/api_bloc_bloc.dart';
import 'package:job_search/app/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:job_search/app/bloc/feed_bloc/feed_bloc.dart';
import 'package:job_search/app/modals/JobModals.dart';
import 'package:job_search/app/screens/bookmarks.dart';
import 'package:job_search/app/screens/explore.dart';
import 'package:job_search/app/screens/settings.dart';
import 'package:job_search/app/screens/work.dart';

import 'package:page_transition/page_transition.dart';

import '../common/common.dart';
import '../common/widgets.dart';
import '../util/utils.dart';
import 'message.dart';

class Home extends StatefulWidget {
  final String title;
  final int initialIndex;

  Home({Key? key, required this.title, required this.initialIndex});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomIndex = 0;
  String currentScreen = "";
  bool isPrevbookmark = false;

  List<Widget> _currentWidget = [Work(), Bookmarks(), Settings()];

  @override
  void initState() {
    super.initState();
    _bottomIndex = widget.initialIndex;
    if (Utils().intEqual(widget.initialIndex, 0)) {
      currentScreen = "home";
    } else if (Utils().intEqual(widget.initialIndex, 1)) {
      currentScreen = "bookmark";
    } else if (Utils().intEqual(widget.initialIndex, 2)) {
      currentScreen = "settings";
    }
  }

  void _onTapIcon(int index) {
    setState(() {
      _bottomIndex = index;
    });
  }

  Widget searchAndControler(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: MediaQuery.of(context).size.width - 90,
                child: TextField(
                  cursorColor: Common().appColor,
                  style: GoogleFonts.lato(),
                  decoration: InputDecoration(
                    labelText: Common().searchJob,
                    labelStyle: TextStyle(color: Common().appColor),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Common().appColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 0.1, color: Common().appColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(width: 1, color: Common().appColor),
                    ),
                  ),
                )),
            IconButton(
              icon: Icon(Icons.tune, color: Common().matteBlack),
              onPressed: () {},
            )
          ],
        ),
      );
  Widget bottomNav(IconData icon, int index, String screen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 3,
          width: 25,
          decoration: BoxDecoration(
              color:
                  (index == _bottomIndex) ? Common().appColor : Common().white,
              borderRadius: BorderRadius.circular(30)),
        ),
        (index == 4)
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Message(
                              tag: "messages",
                              child: messageWidget(),
                              prevScreen: _bottomIndex),
                          type: PageTransitionType.fade));
                },
                child: badge.Badge(
                    // animationType: BadgeAnimationType.scale,
                    badgeContent: Text("3",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            color: Common().white)),
                    child: Hero(
                        tag: "messages",
                        child: Icon(
                          Icons.message,
                          color: Color(0XFF7a7a7a),
                        ))),
              )
            : IconButton(
                icon: Icon(icon,
                    color: (index == _bottomIndex)
                        ? Common().appColor
                        : Color(0XFF7a7a7a)),
                onPressed: () {
                  setState(() {
                    currentScreen = screen;
                  });

                  _onTapIcon(index);
                },
              )
      ],
    );
  }

  Widget messageWidget() => Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Common().appColor, borderRadius: BorderRadius.circular(50)),
      child: Hero(
          tag: "messages",
          child: Icon(
            Icons.message,
            color: Common().white,
          )));
  @override
  Widget build(BuildContext context) {
    Map<String, JobModal> storage = {};
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApiBlocBloc(),
        ),
        BlocProvider(
          create: (context) => FeedBloc()..add(GetFeed()),
        ),
      ],
      child: WillPopScope(
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Widgets()
                      .appBar(context, currentScreen, _bottomIndex, null, null),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: _currentWidget.elementAt(_bottomIndex),
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: Container(
                height: 70,
                decoration: BoxDecoration(color: Common().white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bottomNav((_bottomIndex == 0) ? Icons.work : Icons.home,
                          0, "home"),
                      bottomNav(
                          (_bottomIndex == 1)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          1,
                          "bookmark"),
                      bottomNav(Icons.message, 4, "message"),
                      bottomNav(Icons.settings, 2, "settings"),
                    ],
                  ),
                )),
          ),
          onWillPop: () async => false),
    );
  }
}
