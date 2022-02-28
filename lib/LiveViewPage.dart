import 'package:animations/animations.dart';
import 'package:covid_19_app/ColorTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Api.dart';
import 'Country.dart';
import 'CountryItem.dart';

class LiveViewPage extends StatefulWidget {
  @override
  _LiveViewPageState createState() => _LiveViewPageState();
}

class _LiveViewPageState extends State<LiveViewPage> {
  String _mapStyle;

  GoogleMapController mapController;

  PageController _pageController = PageController(viewportFraction: .9);

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  mapController.setMapStyle(_mapStyle);
                },
                myLocationButtonEnabled: false,
                compassEnabled: false,
                initialCameraPosition:
                    CameraPosition(target: LatLng(45.521563, -2.677433))),
          ),
          Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              right: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: OpenContainer(
                    openBuilder: (context, close) => Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 56,
                              child: Card(
                                child: Row(
                                  children: <Widget>[
                                    BackButton(),
                                    Expanded(child: TextField()),
                                    Icon(Icons.search)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                    closedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    closedBuilder: (context, open) => Container(
                          height: 56,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: ColorTheme.darkBlue,
                                    ),
                                    onPressed: open),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: ColorTheme.darkBlue,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                              Positioned(
                                top: 4,
                                bottom: 0,
                                left: 50,
                                child: Center(
                                  child: Text(
                                    "Search",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: ColorTheme.darkBlue
                                            .withOpacity(.7)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
              )),
          Positioned.fill(
            child: FutureBuilder<List<Country>>(
                future: Query.countries.sort(ApiSort.cases).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: snapshot.data[0].countryInfo.position,
                            zoom: 5)));
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 220,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: snapshot.data.length,
                          onPageChanged: (index) {
                            mapController.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: snapshot
                                        .data[index].countryInfo.position,
                                    zoom: 5)));
                          },
                          itemBuilder: (context, index) {
                            Country country = snapshot.data[index];
                            return CountryItem(country);
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
