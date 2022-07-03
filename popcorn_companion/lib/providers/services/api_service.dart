import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popcorn_companion/constants/api.dart';
import 'package:popcorn_companion/models/api/cast_credit.dart';
import 'package:popcorn_companion/models/api/episode.dart';
import 'package:popcorn_companion/models/api/list_people.dart';
import 'package:popcorn_companion/models/api/list_show.dart';
import 'package:popcorn_companion/models/api/people.dart';
import 'package:popcorn_companion/models/api/show.dart';
import 'package:popcorn_companion/utilities/extensions.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final apiProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: false,
      responseBody: false,
      responseHeader: false,
      error: true,
      compact: true,
    ));
  }

  Future<List<ListShow>> searchShows(String query) async {
    try {
      Response response = await dio.get("${ApiConstants.searchShows}?q=$query");
      return (response.data as List).map((x) => ListShow.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

  Future<List<Episode>> getEpisodes(String id) async {
    try {
      Response response = await dio.get("${ApiConstants.shows}/$id/episodes");
      return (response.data as List).map((x) => Episode.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

  Future<List<Show>> getShowsFromIndexByPage(int pageId) async {
    try {
      Response response = await dio.get("${ApiConstants.shows}?page=$pageId");
      return (response.data as List).map((x) => Show.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

  Future<List<ListPeople>> searchPeople(String query) async {
    try {
      Response response = await dio.get("${ApiConstants.searchPeople}?q=$query");
      return (response.data as List).map((x) => ListPeople.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

  Future<List<People>> getPeopleFromIndexByPage(int pageId) async {
    try {
      Response response = await dio.get("${ApiConstants.people}?page=$pageId");
      return (response.data as List).map((x) => People.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

  Future<List<Episode>> getLocalShowsBySchedule(DateTime day, String country) async {
    try {
      Response response = await dio.get("${ApiConstants.schedule}?country=$country&date=${day.convertToString()}");
      return (response.data as List).map((x) => Episode.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

  Future<List<Episode>> getWebShowsBySchedule(DateTime day) async {
    try {
      Response response = await dio.get("${ApiConstants.scheduleWeb}?date=${day.convertToString()}");
      return (response.data as List).map((x) => Episode.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

  Future<List<CastCredit>> getCastCredits(String id) async {
    try {
      Response response = await dio.get("${ApiConstants.peopleCastCredits}$id/castcredits?embed=show");
      return (response.data as List).map((x) => CastCredit.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }

}
