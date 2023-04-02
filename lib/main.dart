import 'package:daily_tasks/screens/bottom_nav.dart';
import 'package:daily_tasks/screens/home.dart';
import 'package:daily_tasks/screens/notes_page.dart';
import 'package:daily_tasks/screens/search.dart';

import 'package:daily_tasks/screens/sections/private_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //* Done: modify the date (created, modified date)
  //* Done: search for notes
  // ToDo: make cards turn into grid view
  // ToDo: make dark  mode

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        // primarySwatch:  Color.fromARGB(255, 29, 30, 55),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 5,
          actionsIconTheme: IconThemeData(
            color: Colors.black54,
            size: 25,
          ),
          shadowColor: Color.fromARGB(255, 137, 176, 232),
          titleTextStyle: TextStyle(
              color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        accentColor: const Color.fromARGB(255, 151, 148, 180),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 245, 225),
          size: 25,
        ),

        primaryColor: const Color.fromARGB(255, 99, 140, 242),
        primaryColorDark: const Color.fromARGB(255, 80, 73, 130),
        primaryColorLight: const Color.fromARGB(255, 215, 248, 242),
        highlightColor: const Color.fromARGB(50, 29, 30, 55),
        backgroundColor: const Color.fromARGB(255, 253, 248, 239),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 253, 180, 97),
          foregroundColor: Color.fromARGB(255, 255, 245, 225),
        ),
        textTheme: const TextTheme(
          headline3: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        // colorScheme: ColorScheme(brightness: Brightness.light, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface)
      ),
      home: const HomePage(),
      routes: {
        'notes': (context) => const NotesPage(),
        'private': (context) => PrivateScreen(),
        'bottom': (context) => const BottomNavigation(),
        'search': (context) => SearchPage(),
      },
    );
  }
}
