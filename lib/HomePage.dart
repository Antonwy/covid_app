import 'package:animations/animations.dart';
import 'package:covid_19_app/Api.dart';
import 'package:covid_19_app/ColorTheme.dart';
import 'package:covid_19_app/FaqPage.dart';
import 'package:covid_19_app/LiveViewPage.dart';
import 'package:covid_19_app/PreventionPage.dart';
import 'package:covid_19_app/SymptomsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numeral/numeral.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'Country.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ColorTheme.whiteGrey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20),
            sliver: SliverAppBar(
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Stay Home\nStay Safe",
                          style: _theme.textTheme.title.copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.darkBlue),
                        ),
                        SvgPicture.asset(
                          "assets/remote-work-man.svg",
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  preferredSize: Size(double.infinity, 60)),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverStaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 7,
                mainAxisSpacing: 7,
                children: <Widget>[
                  _totalNumbers(),
                  _faq(),
                  _liveView(),
                  _prevention(),
                  _symptoms(),
                ],
                staggeredTiles: [
                  StaggeredTile.fit(2),
                  StaggeredTile.fit(1),
                  StaggeredTile.fit(1),
                  StaggeredTile.fit(1),
                  StaggeredTile.fit(1),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _totalNumbers() {
    return Material(
      color: ColorTheme.darkBlue,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 250),
          child: FutureBuilder<Statistics>(
              future: Query.totalNumbers.get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                Statistics statistics = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Total numbers",
                          style: _theme.textTheme.title
                              .copyWith(color: ColorTheme.whiteGrey),
                        ),
                        Text(
                          timeago.format(statistics.updated),
                          style: _theme.textTheme.body1.copyWith(
                              color: ColorTheme.whiteGrey.withOpacity(.7)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        _statBox(
                            value: statistics.cases,
                            desc: "Affected",
                            color: ColorTheme.indigo),
                        SizedBox(
                          width: 10,
                        ),
                        _statBox(
                            value: statistics.recovered,
                            desc: "Recovered",
                            color: ColorTheme.green),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        _statBox(
                            value: statistics.deaths,
                            desc: "Deaths",
                            color: ColorTheme.red),
                        SizedBox(
                          width: 10,
                        ),
                        _statBox(
                          value: statistics.tests,
                          desc: "Tests",
                          color: ColorTheme.yellow,
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget _statBox({int value, String desc, Color color, bool isLight = false}) {
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Numeral(value).value(),
                style: _theme.textTheme.title.copyWith(
                    color: isLight ? ColorTheme.darkBlue : ColorTheme.whiteGrey,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                desc,
                style: TextStyle(
                    color: isLight
                        ? ColorTheme.darkBlue.withOpacity(.7)
                        : Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _faq() {
    return OpenContainer(
      closedElevation: 0,
      closedColor: ColorTheme.red,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      openBuilder: (context, close) => FaqPage(),
      closedBuilder: (context, open) => Stack(
        children: <Widget>[
          Positioned(
              left: 0,
              bottom: 0,
              child: SvgPicture.asset(
                "assets/mask-man.svg",
                height: 100,
              )),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "FAQ",
                  style: _theme.textTheme.title
                      .copyWith(color: ColorTheme.whiteGrey),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Popular questions and answers.",
                  style:
                      _theme.textTheme.subtitle.copyWith(color: Colors.white70),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Like, where did the new coronavirus (COVID-19) originate?.",
                  style:
                      _theme.textTheme.subtitle.copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: Colors.white10,
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: open,
                        child: Icon(
                          Icons.navigate_next,
                          color: ColorTheme.whiteGrey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _liveView() {
    return OpenContainer(
      closedElevation: 0,
      closedColor: ColorTheme.green,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      openBuilder: (context, close) => LiveViewPage(),
      closedBuilder: (context, open) => Stack(
        children: <Widget>[
          Positioned(
              right: 10,
              bottom: 0,
              child: SvgPicture.asset(
                "assets/remote-work-woman.svg",
                height: 100,
              )),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Live View",
                  style: _theme.textTheme.title
                      .copyWith(color: ColorTheme.whiteGrey),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Get live updates and statistics for Covid-19.",
                  style:
                      _theme.textTheme.subtitle.copyWith(color: Colors.white70),
                ),
                SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: Colors.white10,
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: open,
                        child: Icon(
                          Icons.navigate_next,
                          color: ColorTheme.whiteGrey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _symptoms() {
    return OpenContainer(
      closedElevation: 0,
      closedColor: ColorTheme.yellow,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      openBuilder: (context, close) => SymptomsPage(),
      closedBuilder: (context, open) => Stack(
        children: <Widget>[
          Positioned(
              right: 0,
              bottom: -15,
              child: SvgPicture.asset(
                "assets/fever.svg",
                height: 100,
              )),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Symptoms",
                  style: _theme.textTheme.title
                      .copyWith(color: ColorTheme.whiteGrey),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "These symptoms may appear after 2-14 days after infection.",
                  style: _theme.textTheme.subtitle
                      .copyWith(color: ColorTheme.whiteGrey.withOpacity(.7)),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: ColorTheme.darkBlue.withOpacity(.1),
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: open,
                        child: Icon(
                          Icons.navigate_next,
                          color: ColorTheme.whiteGrey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _prevention() {
    return OpenContainer(
      closedElevation: 0,
      closedColor: Colors.white,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      openBuilder: (context, close) => PreventionPage(),
      closedBuilder: (context, open) => Stack(
        children: <Widget>[
          Positioned(
              right: 0,
              bottom: 0,
              child: SvgPicture.asset(
                "assets/social-distancing.svg",
                height: 100,
              )),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Prevention",
                  style: _theme.textTheme.title
                      .copyWith(color: ColorTheme.darkBlue),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "3 Tips to prevent you getting infected.",
                  style: _theme.textTheme.subtitle
                      .copyWith(color: ColorTheme.darkBlue.withOpacity(.7)),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Material(
                      color: ColorTheme.darkBlue.withOpacity(.1),
                      elevation: 0,
                      clipBehavior: Clip.antiAlias,
                      shape: CircleBorder(),
                      child: InkWell(
                        onTap: open,
                        child: Icon(
                          Icons.navigate_next,
                          color: ColorTheme.darkBlue,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
