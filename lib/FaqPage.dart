import 'package:covid_19_app/ColorTheme.dart';
import 'package:covid_19_app/Faq.dart';
import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: ColorTheme.whiteBlue,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
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
                              "FAQ",
                              style: _theme.textTheme.title.copyWith(
                                  color: ColorTheme.whiteGrey, fontSize: 30),
                            ),
                            Text(
                              "Frequently asked questions.",
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
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            sliver: SliverList(
                delegate: SliverChildListDelegate(Faq.faqs
                    .map((Faq faq) => Theme(
                          data: ThemeData(
                              accentColor: ColorTheme.whiteGrey,
                              unselectedWidgetColor:
                                  ColorTheme.whiteGrey.withOpacity(.7)),
                          child: ExpansionTile(
                            title: Text(
                              faq.question,
                              style: TextStyle(
                                  color: ColorTheme.whiteGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10),
                                child: Text(
                                  faq.answer,
                                  style: TextStyle(
                                      color:
                                          ColorTheme.whiteGrey.withOpacity(.7)),
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList())),
          )
        ],
      ),
    );
  }
}
