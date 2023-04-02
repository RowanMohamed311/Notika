import 'package:daily_tasks/screens/notes_page.dart';
import 'package:daily_tasks/screens/password/enter_password.dart';
import 'package:daily_tasks/screens/password/new_password.dart';
import 'package:daily_tasks/screens/record_notes.dart';
import 'package:daily_tasks/screens/sections/archived_screen.dart';
import 'package:daily_tasks/screens/sections/important_screen.dart';
import 'package:daily_tasks/screens/sections/private_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTab = 0;
  int? _pass;
  final List<Color> colors = [
    const Color.fromARGB(255, 80, 73, 130),
    const Color.fromARGB(255, 235, 167, 247),
    const Color.fromARGB(255, 248, 167, 174),
    const Color.fromARGB(255, 240, 182, 114),
    const Color.fromARGB(255, 151, 148, 180)
  ];
  final List<Widget> screens = [
    const NotesPage(),
    ImportantScreen(),
    PrivateScreen(),
    ArchiveScreen(),
  ];
  final PageStorageBucket _bucket = PageStorageBucket();
  Widget currentScreen = const NotesPage();

  void loadPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pass = (prefs.getInt('password') ?? 0);
    });
  }

  @override
  void initState() {
    super.initState();
    loadPass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageStorage(
        bucket: _bucket,
        child: currentScreen,
      ),
      // drawer: const Drawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        // heroTag: 'expand_save',
        elevation: 12,
        highlightElevation: 50,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RecordNotes(),
            ),
          );
          // refreshNotes();
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = const NotesPage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? colors[0] : colors[4],
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? colors[0] : colors[4],
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = ImportantScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: currentTab == 1 ? colors[0] : colors[4],
                        ),
                        Text(
                          'Star',
                          style: TextStyle(
                            color: currentTab == 1 ? colors[0] : colors[4],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = _pass == 0
                            ? NewPassword(
                                // pass: ,
                                )
                            : EnterPassword(
                                pass: _pass!,
                              );
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: currentTab == 2 ? colors[0] : colors[4],
                        ),
                        Text(
                          'Private',
                          style: TextStyle(
                            color: currentTab == 2 ? colors[0] : colors[4],
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = ArchiveScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.archive,
                          color: currentTab == 3 ? colors[0] : colors[4],
                        ),
                        Text(
                          'Archive',
                          style: TextStyle(
                            color: currentTab == 3 ? colors[0] : colors[4],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
