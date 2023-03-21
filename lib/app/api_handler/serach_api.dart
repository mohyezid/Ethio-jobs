// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:job_search/app/modals/JobModals.dart';

class ApiHandler {
  static Future<List<JobModal>> searchAllJob() async {
    final res = await http.get(
        Uri.parse("https://jsearch.p.rapidapi.com/search?query=all"),
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

      return JobModal.ListJobs(temp);
    } else {
      throw 'Server Error';
    }
  }

  static Future<List<JobModal>> searchqueryJob(String querys) async {
    final search = querys.trim();
    final res = await http.get(
        Uri.parse("https://jsearch.p.rapidapi.com/search?query=$search"),
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

      return JobModal.ListJobs(temp);
    } else {
      throw "server Error";
    }
  }
}
