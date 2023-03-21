import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_search/app/modals/JobModals.dart';

import 'package:page_transition/page_transition.dart';

import '../bloc/bookmark_bloc/bookmark_bloc.dart';
import '../common/common.dart';
import 'job.dart';

class Bookmarks extends StatefulWidget {
  @override
  _BookmarksState createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    Widget bookmarked(JobModal job, String position, String company,
            String location, String desc, String applylink) =>
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: Job(
                      job: job,
                      applyLink: applylink,
                      position: position,
                      company: company,
                      location: location,
                      isBookmark: true,
                      desc: desc,
                    ),
                    type: PageTransitionType.fade));
          },
          child: Card(
            shadowColor: Common().appColor,
            child: Container(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Image.asset(
                        Common().ipsum3,
                        width: 120,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 190,
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
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: Common().matteBlack)),
                            ),
                            Container(
                              width: 190,
                              child: Text(location,
                                  style: GoogleFonts.lato(
                                      fontSize: 16,
                                      color: Common().matteBlack)),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Icon(Icons.access_time,
                                            color: Common().appColor),
                                      ),
                                      Expanded(
                                        child: Text("20 min ago",
                                            style: GoogleFonts.lato(
                                                fontSize: 16,
                                                color: Common().appColor)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Icon(
                                          Icons.work,
                                          color: Common().appColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text("Full-time",
                                            style: GoogleFonts.lato(
                                                fontSize: 16,
                                                color: Common().appColor)),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<BookmarkBloc>(context)
                                          .add(BookmarkRemoved(id: job.jobId!));
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.red))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      builder: (context, state) {
        if (state is Bookmarksucced) {
          return Container(
            child: ListView.builder(
              itemCount: state.jobs.length,
              itemBuilder: (context, index) {
                return bookmarked(
                  state.jobs[index],
                  state.jobs[index].jobTitle ?? "Flutter Developer",
                  state.jobs[index].employerName ?? "IT Company",
                  state.jobs[index].jobCountry ?? "Singapore",
                  state.jobs[index].jobDescription ?? Common().backEnd,
                  state.jobs[index].jobApplyLink ?? '',
                );
              },
            ),
          );
        }
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.filter_drama_rounded,
              size: 23,
            ),
            Text(
              'No Bookmark Job Found',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ));
      },
    );
  }
}
// bookmarked("Flutter Developer", "IT Company", "Singapore",
//                   Common().Flutter, ""),