import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:bubble/bubble.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:job_search/app/bloc/api_bloc/api_bloc_bloc.dart';
import 'package:job_search/app/modals/JobModals.dart';
import 'package:job_search/app/screens/work.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../api_handler/serach_api.dart';
import '../common/common.dart';
import '../common/widgets.dart';
import '../util/utils.dart';
import 'job.dart';

class Search extends StatefulWidget {
  late TextEditingController search;
  Search({super.key, required this.search});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int currPage = 2;
  final int totalpage = 8;
  List<JobModal> newfetch = [];
  Future<bool> getNewdata(String search) async {
    if (currPage >= totalpage) {
      refreshController.loadNoData();
      return true;
    }
    final res = await http.get(
        Uri.parse(
            "https://jsearch.p.rapidapi.com/search?query=$search&page=$currPage"),
        headers: {
          "X-RapidAPI-Key":
              "57efa40800msh2c93f94d2fd9862p178eccjsn272d1dd6f700",
          "X-RapidAPI-Host": "jsearch.p.rapidapi.com"
        });
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      var temp = [];

      for (var i in data['data']) {
        temp.add(i);
      }
      final jobs = JobModal.ListJobs(temp);
      if (jobs.isNotEmpty) {
        currPage += 1;
        newfetch.addAll(jobs);
        setState(() {});
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  String r = "";
  final RefreshController refreshController = RefreshController();
  Future<void> reFetchData() async {
    BlocProvider.of<ApiBlocBloc>(context)
        .add(SearchJobs(search: widget.search.text));
  }

  Widget job(
          JobModal job,
          BuildContext context,
          String position,
          String tag,
          String company,
          String location,
          String? image,
          String? jobkind,
          String desc,
          String applylink) =>
      InkWell(
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
                    Hero(
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
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 230,
                          child: Text(position,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Common().appColor)),
                        ),
                        Container(
                          width: 190,
                          child: Text(company,
                              style: GoogleFonts.lato(
                                  fontSize: 18, color: Common().matteBlack)),
                        ),
                        Container(
                          width: 190,
                          child: Text(location,
                              style: GoogleFonts.lato(
                                  fontSize: 16, color: Common().matteBlack)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time,
                                    color: Common().appColor),
                                Text("${Random().nextInt(51) + 10} minutes ago",
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
                                Text(
                                    jobkind != null
                                        ? toBeginningOfSentenceCase(
                                            jobkind.toLowerCase())!
                                        : "Full Time",
                                    style: TextStyle(
                                      letterSpacing: 3,
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            )),
      );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              Widgets().appBar(context, "search", 0, null, null),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width - 90,
                        child: TextField(
                          controller: widget.search,
                          cursorColor: Common().appColor,
                          style: GoogleFonts.lato(),
                          decoration: InputDecoration(
                            hintText: Common().searchJob,
                            hintStyle:
                                GoogleFonts.lato(color: Common().appColor),
                            suffixIcon: IconButton(
                              onPressed: () {
                                print(widget.search.text);
                              },
                              icon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<ApiBlocBloc>(context).add(
                                      SearchJobs(search: widget.search.text));
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: Common().appColor,
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 0.1, color: Common().appColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  width: 0.5, color: Common().appColor),
                            ),
                          ),
                        )),
                    IconButton(
                      icon: Icon(Icons.tune, color: Common().appColor),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              BlocBuilder<ApiBlocBloc, ApiBlocState>(
                builder: (context, state) {
                  if (state is ApiSearchFailure) {
                    return Container();
                  }
                  if (state is ApiBlocInitial) {
                    BlocProvider.of<ApiBlocBloc>(context)
                        .add(SearchJobs(search: widget.search.text));
                  }
                  if (state is ApiSearchsuccess) {
                    List<JobModal> temp = state.jobs;
                    temp.addAll(newfetch);
                    return Expanded(
                        child: SmartRefresher(
                      physics: BouncingScrollPhysics(),
                      controller: refreshController,
                      onRefresh: () async {
                        await reFetchData();
                      },
                      enablePullUp: true,
                      onLoading: () async {
                        final res = await getNewdata(widget.search.text);
                        if (res) {
                          refreshController.loadComplete();
                        } else {
                          refreshController.loadFailed();
                        }
                      },
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: temp.length,
                        itemBuilder: (context, index) {
                          return job(
                              temp[index],
                              context,
                              temp[index].jobTitle ?? "Finance",
                              "$index",
                              temp[index].employerName ?? "IT Company",
                              '${temp[index].jobCity ?? "Quezon City,"} ${temp[index].jobCountry ?? "PH"}',
                              temp[index].employerLogo,
                              temp[index].jobEmploymentType ?? "Full Time",
                              temp[index].jobDescription!,
                              temp[index].jobApplyLink!);
                        },
                      ),
                    ));
                  }

                  return SizedBox(
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
                  );
                },
              )
            ],
          ),
        )),
        onWillPop: () async => true);
  }
}
// LoadingIndicator(
//     indicatorType: Indicator.ballPulse, /// Required, The loading type of the widget
//     colors: const [Colors.white],       /// Optional, The color collections
//     strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
//     backgroundColor: Colors.black,      /// Optional, Background of the widget
//     pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
// )