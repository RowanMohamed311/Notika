import 'package:daily_tasks/widgets/appbar.dart';
import 'package:daily_tasks/widgets/tiles.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Header(title: 'Notika', context: context),
        backgroundColor: Theme.of(context).backgroundColor,
        body: const Center(
          child: TilesList(screen_flag: 0),
        ),
      ),
    );
  }
}
