import 'dart:convert';
import 'dart:math';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_search/app/api_handler/serach_api.dart';
import 'package:job_search/app/bloc/api_bloc/api_bloc_bloc.dart';
import 'package:job_search/app/bloc/login_bloc/login_bloc.dart';
import 'package:job_search/app/modals/JobModals.dart';
import 'package:job_search/app/screens/search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import '../bloc/feed_bloc/feed_bloc.dart';
import '../common/common.dart';
import '../modals/Profiledata.dart';
import 'job.dart';

class Work extends StatefulWidget {
  @override
  _WorkState createState() => _WorkState();
}

class _WorkState extends State<Work> {
  int _currentIndex = 0;
  int currPage = 2;
  final int totalpage = 20;
  List<JobModal> newfetch = [];
  final RefreshController refreshController = RefreshController();
  final categoryList = ["all", "design", "software", "business", "realstate"];
  Future<bool> getNewdata(String search) async {
    if (currPage >= totalpage) {
      refreshController.loadNoData();
      return true;
    }
    // final res = await http.get(
    //     Uri.parse(
    //         "https://jsearch.p.rapidapi.com/search?query=$search&page=$currPage"),
    //     headers: {
    //       "X-RapidAPI-Key":
    //           "25b9974672msh6c7c3ec36527930p10e3e0jsn3054b13e7962",
    //       "X-RapidAPI-Host": "jsearch.p.rapidapi.com"
    //     });
    // if (res.statusCode == 200) {
    //   final data = jsonDecode(res.body);
    //   var temp = [];

    //   for (var i in data['data']) {
    //     temp.add(i);
    //   }
    final temp = await ApiHandler.searchAllJob();
    if (temp.isNotEmpty) {
      currPage += 1;
      newfetch.addAll(temp);
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  Widget searchAndControler(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: MediaQuery.of(context).size.width - 90,
              child: TextField(
                controller: search,
                cursorColor: Common().appColor,
                style: GoogleFonts.lato(),
                decoration: InputDecoration(
                  hintText: Common().searchJob,
                  hintStyle: GoogleFonts.lato(color: Common().appColor),
                  suffixIcon: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider(
                            create: (_) => ApiBlocBloc(),
                            child: Search(
                              search: search,
                            ),
                          );
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.search,
                      color: Common().appColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 0.1, color: Common().appColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 0.5, color: Common().appColor),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget greetings(ProfileState data) => Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    width: 170,
                    child: Text(data.name!.split(' ')[0],
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Common().matteBlack)),
                  ),
                  Container(
                    width: 170,
                    child: Text(Common().findPerfectJob,
                        style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Common().appColor)),
                  )
                ],
              )),
        ],
      ));
  Widget category(int index, String title) => Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          if (_currentIndex != index) {
            BlocProvider.of<FeedBloc>(context).add(GetFilter(search: title));
            setState(() {
              _currentIndex = index;
            });
          }
          return;
        },
        child: Container(
          height: 40,
          width: 70,
          decoration: BoxDecoration(
              color:
                  (_currentIndex != index) ? Common().white : Common().appColor,
              border: Border.all(color: Common().appColor, width: 0.5),
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(title,
                style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: (_currentIndex != index)
                        ? Common().appColor
                        : Common().white)),
          ),
        ),
      ));
  Widget jobCategories(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(Common().jobCategories,
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Common().appColor)),
                    ))),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  category(0, Common().all),
                  category(1, Common().design),
                  category(2, Common().software),
                  category(3, Common().business),
                  category(4, Common().realState),
                ],
              ),
            ),
          ),
        ],
      ));
  Widget job(
          JobModal job,
          BuildContext context,
          String position,
          String tag,
          String company,
          String location,
          String image,
          String desc,
          String applylink,
          bool jobkind) =>
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Job(
                job: job,
                applyLink: applylink,
                desc: desc,
                position: position,
                company: company,
                location: location,
                isBookmark: false,
              );
            },
          ));
        },
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Card(
              shadowColor: Common().appColor,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: tag,
                        child: image == null
                            ? Image.asset(
                                Common().ipsum,
                                width: 120,
                              )
                            : FancyShimmerImage(
                                imageUrl: image,
                                boxFit: BoxFit.contain,
                                width: 120,
                                errorWidget: Image.asset(
                                  Common().ipsum,
                                  width: 120,
                                ),
                              ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            child: Text(position,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Common().appColor)),
                          ),
                          Container(
                            width: 190,
                            child: Text(company,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: GoogleFonts.lato(
                                    fontSize: 18, color: Common().matteBlack)),
                          ),
                          Container(
                            width: 190,
                            child: Text(location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: GoogleFonts.lato(
                                    fontSize: 16, color: Common().matteBlack)),
                          ),
                          Divider(),
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Common().appColor),
                                  Text(
                                      "${Random().nextInt(50) + 10} minutes ago",
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: Common().appColor))
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.work,
                                    color: Common().appColor,
                                  ),
                                  Text(jobkind ? "Remote" : "Full Time",
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          color: Common().appColor))
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      );
  Widget recommendedJob(
          JobModal job,
          String position,
          String company,
          String location,
          String image,
          String desc,
          String applylink,
          bool jobKind) =>
      Padding(
          padding: const EdgeInsets.only(left: 5),
          child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Job(
                      job: job,
                      applyLink: applylink,
                      position: position,
                      company: company,
                      location: location,
                      isBookmark: false,
                      desc: desc,
                    );
                  },
                ));
              },
              child: Card(
                shadowColor: Common().appColor,
                child: Container(
                  width: 280,
                  height: 260,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Hero(
                          tag: company,
                          child: image == null
                              ? Image.asset(
                                  Common().ipsum,
                                  width: 120,
                                )
                              : FancyShimmerImage(
                                  imageUrl: image,
                                  height: 90,
                                  boxFit: BoxFit.fill,
                                  errorWidget: Image.asset(
                                    Common().ipsum,
                                    width: 120,
                                  ),
                                ),
                        ),
                      ),
                      Text(
                        position,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Common().appColor),
                      ),
                      Text(
                        company,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Common().appColor),
                      ),
                      Text(
                        location,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lato(
                            fontSize: 18, color: Common().appColor),
                      ),
                      Divider(),
                      Container(
                        width: 250,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: Common().appColor),
                                Text("${Random().nextInt(50) + 10} minutes ago",
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Common().appColor))
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.work,
                                  color: Common().appColor,
                                ),
                                Text(jobKind ? "Remote" : "Full Time",
                                    style: GoogleFonts.lato(
                                        fontSize: 16, color: Common().appColor))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )));
  Widget recommendedJobList({required List<JobModal> jobs}) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Text(Common().recommendedJobs,
                          style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Common().appColor)),
                    ))),
          ),
          Container(
              height: 260,
              //  decoration: BoxDecoration(color: Common().appColor),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    int inx = Random().nextInt(jobs.length);
                    return recommendedJob(
                        jobs[inx],
                        jobs[inx].jobTitle ?? "Flutter Developer",
                        jobs[inx].employerName ?? "IT Company",
                        jobs[inx].jobCountry ?? "Singapore",
                        jobs[inx].employerLogo ?? Common().ipsum2,
                        jobs[inx].jobDescription ?? Common().backEnd,
                        jobs[inx].jobApplyLink ?? '',
                        jobs[inx].jobIsRemote ?? false);
                  },
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                ),
              )),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LogInSuccess) {
          return Column(
            children: [
              greetings(state.pdata),
              searchAndControler(context),
              jobCategories(context),
              BlocBuilder<FeedBloc, FeedState>(
                builder: (context, state) {
                  if (state is FeedInFailure) {
                    return Container();
                  }
                  if (state is FeedInSuccess) {
                    List<JobModal> temp = state.jobs;
                    temp.addAll(newfetch);
                    return Expanded(
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SmartRefresher(
                          controller: refreshController,
                          enablePullUp: true,
                          onLoading: () async {
                            final res =
                                await getNewdata(categoryList[_currentIndex]);
                            if (res) {
                              refreshController.loadComplete();
                            } else {
                              refreshController.loadFailed();
                            }
                          },
                          child: ListView(
                            children: [
                              recommendedJobList(jobs: state.jobs),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                        width: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3),
                                          child: Text(Common().recentJobs,
                                              style: GoogleFonts.lato(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Common().appColor)),
                                        ))),
                              ),

                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: temp.length,
                                itemBuilder: (context, index) {
                                  return job(
                                      temp[index],
                                      context,
                                      temp[index].jobTitle ??
                                          "Mobile Developer",
                                      '$index',
                                      temp[index].employerName ?? "IT Company",
                                      '${temp[index].jobCity ?? "Quezon City"}${temp[index].jobCountry ?? "PH"}',
                                      temp[index].employerLogo ??
                                          Common().ipsum,
                                      temp[index].jobDescription ??
                                          Common().Flutter,
                                      temp[index].jobApplyLink ?? "",
                                      temp[index].jobIsRemote ?? false);
                                },
                              ),

                              // job(context, "Real Time Analyst", "1", "IT Company",
                              //     "Quezon City, PH", Common().ipsum3),
                              // job(context, "Java EE Developer", "2", "IT Company",
                              //     "Quezon City, PH", Common().ipsum2),
                              // job(context, "UI/UX Developer", "3", "IT Company",
                              //     "Quezon City, PH", Common().ipsum),
                              // job(context, "AWS Administrator", "4", "IT Company",
                              //     "National Capital Region", Common().ipsum3),
                              // job(context, "Administrator", "5", "IT Company",
                              //     "National Capital Region", Common().ipsum),
                              // job(context, "Real Time Analyst", "6", "IT Company",
                              //     "Quezon City, PH", Common().ipsum3),
                              // job(context, "Real Time Analyst", "7", "IT Company",
                              //     "Quezon City, PH", Common().ipsum2),
                            ],
                          ),
                        ),
                      )),
                    );
                  }
                  return Expanded(
                    child: SizedBox(
                      height: 300,
                      child: Center(
                          child: SpinKitDoubleBounce(
                        duration: Duration(seconds: 2),
                        size: 75,
                        itemBuilder: (context, index) {
                          final colors = [
                            Color.fromARGB(255, 115, 93, 212),
                            Color.fromARGB(255, 57, 47, 102),
                            Color.fromARGB(255, 15, 23, 31),
                          ];
                          final color = colors[index % colors.length];
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color: color, shape: BoxShape.circle));
                        },
                      )),
                    ),
                  );
                },
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
