import 'dart:io';

import 'package:dio/dio.dart';
import 'package:popcorn_companion/constants/constants.dart';

import '../../models/list_show.dart';

class NetworkService {
  final Dio dio = Dio();

  Future<List<ListShow>> search(String query) async {
    try {
      Response response = await dio.get("${Constants.baseUrl}/search/shows?q=$query");
      return (response.data as List).map((x) => ListShow.fromJson(x)).toList();
    } catch (e) {
      throw SocketException("$e");
    }
  }
}
