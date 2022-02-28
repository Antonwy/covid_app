import 'package:covid_19_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        textTheme: TextTheme(
          title: GoogleFonts.josefinSans(fontWeight: FontWeight.bold),
          body1: GoogleFonts.josefinSans(fontSize: 16),
          caption: GoogleFonts.josefinSans(fontSize: 12),
          subtitle: GoogleFonts.josefinSans(fontWeight: FontWeight.w600)
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: ZoomPageTransitionsBuilder()
          },
        ),
      ),
      home: HomePage(),
    );
  }
}
