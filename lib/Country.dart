import 'package:google_maps_flutter/google_maps_flutter.dart';

class Statistics {
  DateTime updated;
  int cases,
      todayCases,
      deaths,
      todayDeaths,
      recovered,
      active,
      critical,
      casesPerOneMillion,
      deathsPerOneMillion,
      tests,
      testsPerOneMillion;

  Statistics({
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.updated,
  });

  static Statistics fromMap(map) {
    return Statistics(
        cases: map["cases"],
        todayCases: map["todayCases"],
        deaths: map["deaths"],
        todayDeaths: map["todayDeaths"],
        recovered: map["recovered"],
        active: map["active"],
        critical: map["critical"],
        casesPerOneMillion: map["casesPerOneMillion"],
        deathsPerOneMillion: map["deathsPerOneMillion"],
        tests: map["tests"],
        testsPerOneMillion: map["testsPerOneMillion"].round(),
        updated: DateTime.fromMillisecondsSinceEpoch(map["updated"]));
  }
}

class Country extends Statistics {
  String country, continent;

  CountryInfo countryInfo;

  Country(
      {int cases,
      int todayCases,
      int deaths,
      int todayDeaths,
      int recovered,
      int active,
      int critical,
      int casesPerOneMillion,
      int deathsPerOneMillion,
      int tests,
      int testsPerOneMillion,
      DateTime updated,
      this.continent,
      this.country,
      this.countryInfo})
      : super(
            cases: cases,
            todayCases: todayCases,
            deaths: deaths,
            todayDeaths: todayDeaths,
            recovered: recovered,
            active: active,
            critical: critical,
            casesPerOneMillion: casesPerOneMillion,
            deathsPerOneMillion: deathsPerOneMillion,
            tests: tests,
            testsPerOneMillion: testsPerOneMillion,
            updated: updated);

  static Country fromMap(map) {
    return Country(
        cases: map["cases"],
        todayCases: map["todayCases"],
        deaths: map["deaths"],
        todayDeaths: map["todayDeaths"],
        recovered: map["recovered"],
        active: map["active"],
        critical: map["critical"],
        casesPerOneMillion: map["casesPerOneMillion"],
        deathsPerOneMillion: map["deathsPerOneMillion"],
        tests: map["tests"],
        testsPerOneMillion: map["testsPerOneMillion"],
        updated: DateTime.fromMillisecondsSinceEpoch(map["updated"]),
        continent: map["continent"],
        country: map["country"],
        countryInfo: CountryInfo.fromMap(map["countryInfo"]));
  }

  static List<Country> fromMapToList(list) {
    return list.map<Country>(fromMap).toList();
  }

  @override
  String toString() {
    return country;
  }
}

class CountryInfo {
  int id;
  LatLng position;
  String iso2, iso3, flag;

  CountryInfo({this.id, this.position, this.iso2, this.iso3, this.flag});

  static CountryInfo fromMap(Map<String, dynamic> map) => CountryInfo(
        id: map["_id"],
        iso2: map["iso2"],
        iso3: map["iso3"],
        position: LatLng(map["lat"].toDouble(), map["long"].toDouble()),
        flag: map["flag"],
      );
}
