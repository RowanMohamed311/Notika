import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('bottom');
          },
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Notika',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pacifico(
                    color: Theme.of(context).primaryColorDark,
                    fontStyle: FontStyle.italic,
                    fontSize: 60,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Tap to Continue',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
