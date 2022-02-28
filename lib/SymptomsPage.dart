import 'package:covid_19_app/ColorTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import 'Helper.dart';
import 'Strings.dart';

class SymptomsPage extends StatelessWidget {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ColorTheme.whiteGrey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: ColorTheme.darkBlue),
            bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Covid-19"),
                            SizedBox(height: 5,),
                            Text(
                              "Symptoms",
                              style: _theme.textTheme.title
                                  .copyWith(color: ColorTheme.darkBlue, fontSize: 30),
                            ),
                            Text(
                              "These symptoms may appear after 2-14 days after infection.",
                              style: _theme.textTheme.caption.copyWith(
                                  color: ColorTheme.darkBlue.withOpacity(.7)),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            child: Material(
                              color: Helper.hexToColor("#ffc66a"),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/fever.svg",
                            height: 90,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                preferredSize: Size(double.infinity, 80)),
          ),
          SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverStaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: <Widget>[
                _symptomBox(
                    title: "Fever",
                    desc: Strings.feverDesc,
                    illustration: "fever"),
                _symptomBox(
                    title: "Dry Cough",
                    desc: Strings.dryCoughDesc,
                    illustration: "dry-cough"),
                _symptomBox(
                    title: "Headache",
                    desc: Strings.headacheDesc,
                    illustration: "headache"),
                _symptomBox(
                    title: "Vomit",
                    desc: Strings.vomitDesc,
                    illustration: "fever"),
              ],
              staggeredTiles: [
                StaggeredTile.fit(1),
                StaggeredTile.fit(1),
                StaggeredTile.fit(1),
                StaggeredTile.fit(1),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _symptomBox({String title, String desc, String illustration}) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: -20,
              right: -10,
              child: SvgPicture.asset(
                "assets/$illustration.svg",
                height: 130,
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: _theme.textTheme.title
                      .copyWith(color: ColorTheme.darkBlue),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  desc,
                  style: _theme.textTheme.body1
                      .copyWith(color: ColorTheme.darkBlue.withOpacity(.7)),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
