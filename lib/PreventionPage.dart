import 'package:covid_19_app/ColorTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Strings.dart';

class PreventionPage extends StatelessWidget {
  ThemeData _theme;
  PageController _pageController = PageController(viewportFraction: .9);

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ColorTheme.indigo,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: ColorTheme.whiteGrey),
            bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Covid-19",
                              style: TextStyle(color: ColorTheme.whiteGrey),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Prevention",
                              style: _theme.textTheme.title.copyWith(
                                  color: ColorTheme.whiteGrey, fontSize: 30),
                            ),
                            Text(
                              "Important tips to prevent getting infected.",
                              style: _theme.textTheme.caption.copyWith(
                                  color: ColorTheme.whiteGrey.withOpacity(.7)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size(double.infinity, 80)),
          ),
          SliverFillRemaining(
            child: SafeArea(
              top: false,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Container(
                        height: 500,
                        child: PageView(
                          controller: _pageController,
                          children: <Widget>[
                            _preventBox(
                                title: "Wash Hands",
                                desc: Strings.washHandsDesc,
                                illustration: "wash-hands"),
                            _preventBox(
                                title: "Wear Masks",
                                desc: Strings.wearMasksDesc,
                                illustration: "medical-care"),
                            _preventBox(
                                title: "Social Distancing",
                                desc: Strings.socialDistancingDesc,
                                illustration: "social-distancing"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: ColorTheme.whiteGrey.withOpacity(.5),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "More infos about Covid-19.",
                          style: TextStyle(color: ColorTheme.whiteGrey),
                        ),
                        InkWell(
                          onTap: () async {
                            if (await canLaunch(Strings.whoUrl)) {
                              launch(Strings.whoUrl);
                            }
                          },
                          child: Text(
                            "More",
                            style: TextStyle(
                                color: ColorTheme.whiteGrey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _preventBox({String title, String desc, String illustration}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: ColorTheme.whiteGrey,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/$illustration.svg",
                height: 200,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                title,
                style: _theme.textTheme.title
                    .copyWith(color: ColorTheme.darkBlue, fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: _theme.textTheme.body1
                    .copyWith(color: ColorTheme.darkBlue.withOpacity(.7)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
