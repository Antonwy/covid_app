import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid_19_app/ColorTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numeral/numeral.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'Country.dart';
import 'Helper.dart';

class CountryItem extends StatelessWidget {
  Country country;

  CountryItem(this.country);
  ThemeData _theme;

  MediaQueryData _mq;

  Color color = ColorTheme.whiteGrey;

  Color containerColor = ColorTheme.whiteGreyDark;

  Color textColor = ColorTheme.whiteGreyText;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    _mq = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, _mq.padding.bottom),
      child: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedElevation: 20,
        closedColor: color,
        openColor: color,
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        tappable: false,
        openBuilder: (context, close) => Stack(
          children: <Widget>[
            Positioned(
              bottom: -150,
              left: -80,
              child: SizedBox(
                  height: 500,
                  child: SvgPicture.asset("assets/doctor-woman.svg")),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: _mq.padding.top,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    BackButton(
                      onPressed: close,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Details",
                      style: _theme.textTheme.title,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAlias,
                        child: CachedNetworkImage(
                          imageUrl: country.countryInfo.flag,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            country.country,
                            style: _theme.textTheme.title,
                          ),
                          Text(
                            timeago.format(country.updated),
                            style: _theme.textTheme.subtitle
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            Numeral(country.tests).value(),
                            style: _theme.textTheme.title,
                          ),
                          Text(
                            "Tested",
                            style: _theme.textTheme.subtitle
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: StaggeredGridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        children: <Widget>[
                          _statCard(
                              value: country.cases,
                              text: "Affected",
                              color: Helper.hexToColor("#df565e")),
                          _statCard(
                              value: country.recovered,
                              text: "Recovered",
                              color: Helper.hexToColor("#40ca64")),
                          _statCard(
                              text: "Today cases", value: country.todayCases),
                          _statCard(
                              text: "Today deaths", value: country.todayDeaths),
                          _statCard(text: "Active", value: country.active),
                          _statCard(text: "Critical", value: country.critical),
                          _statCard(
                              text: "Cases per one Million",
                              value: country.casesPerOneMillion),
                          _statCard(
                              text: "Tests per one Million",
                              value: country.testsPerOneMillion),
                          _statCard(
                            text: "Deaths per one Million",
                            value: country.deathsPerOneMillion,
                          ),
                          _statCard(text: "Deaths", value: country.deaths)
                        ],
                        staggeredTiles: [
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                          StaggeredTile.fit(1),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
        closedBuilder: (context, open) => InkWell(
          onTap: open,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAlias,
                      elevation: 6,
                      child: CachedNetworkImage(
                        imageUrl: country.countryInfo.flag,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          country.country,
                          style: _theme.textTheme.title,
                        ),
                        Text(
                          timeago.format(country.updated),
                          style: _theme.textTheme.subtitle
                              .copyWith(color: Colors.black45),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          Numeral(country.tests).value(),
                          style: _theme.textTheme.title,
                        ),
                        Text(
                          "Tested",
                          style: _theme.textTheme.subtitle
                              .copyWith(color: Colors.black45),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Material(
                          borderRadius: BorderRadius.circular(15),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Helper.hexToColor("#df565e"),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Numeral(country.cases).value(),
                                    style: _theme.textTheme.title.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Affected",
                                    style: TextStyle(color: Colors.white54),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Material(
                          borderRadius: BorderRadius.circular(15),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Helper.hexToColor("#40ca64"),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Numeral(country.recovered).value(),
                                    style: _theme.textTheme.title.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Recovered",
                                    style: TextStyle(color: Colors.white54),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard({int value, String text, Color color}) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? containerColor,
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Numeral(value).value(),
              style: _theme.textTheme.title.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color == null ? textColor : Colors.white),
            ),
            Text(
              text,
              style: TextStyle(color: color == null ? textColor : Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
