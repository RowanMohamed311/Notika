import 'package:daily_tasks/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/note.dart';
import '../screens/bottom_nav.dart';

AppBar Header(
    {required String title,
    required BuildContext context,
    bool showLeading = false}) {
  return AppBar(
    centerTitle: false,
    backgroundColor: Theme.of(context).backgroundColor,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(),
            ),
            (Route<dynamic> route) => false,
          );
        },
        icon: const Icon(Icons.search),
      ),
    ],
    leading: showLeading
        ? IconButton(
            color: Theme.of(context).primaryColorDark,
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigation(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          )
        : Image.asset(
            'assets/icons/notikanew.png',
            alignment: Alignment.centerRight,
            scale: 1.5,
            filterQuality: FilterQuality.high,
          ),
    title: Text(
      title,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      style: GoogleFonts.aBeeZee(
        color: Colors.black54,
        fontStyle: FontStyle.normal,
        fontSize: 25,
      ),
    ),
    elevation: 0,
    // leadingWidth: 50,
  );
}
