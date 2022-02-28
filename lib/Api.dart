import 'dart:async';
import 'dart:convert';
import 'package:covid_19_app/Country.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/services.dart';

import 'Strings.dart';

class Query {
  Route route;
  static Dio _dio;

  static Dio get dio {
    if (_dio == null) {
      _dio = Dio(BaseOptions(baseUrl: Strings.apiBaseUrl))
        ..interceptors.add(
            DioCacheManager(CacheConfig(baseUrl: Strings.apiBaseUrl))
                .interceptor);
    }
    return _dio;
  }

  Query._(this.route);

  static Route<List<Country>> get countries => Route<List<Country>>(
      route: Strings.countries, mapper: Country.fromMapToList);

  static Route<Statistics> get totalNumbers =>
      Route<Statistics>(route: Strings.all, mapper: Statistics.fromMap);
}

class Route<T> {
  String route;
  String sortString;
  T Function(dynamic) mapper;

  Route({this.route, this.sortString, this.mapper});

  Route<T> sort(String sort) =>
      Route<T>(route: this.route, sortString: sort, mapper: this.mapper);

  Future<T> get() async {
    Response res = await Query.dio
        .get(this.toString(), options: buildCacheOptions(Duration(hours: 1)));

    return mapper(res.data);
  }

  @override
  String toString() {
    return Strings.apiBaseUrl +
        route +
        (sortString != null ? "?sort=$sortString" : "");
  }
}

class ApiSort {
  ApiSort._();

  static final cases = "cases";
  static final todayCases = "todayCases";
  static final deaths = "deaths";
  static final todayDeaths = "todayDeaths";
}
