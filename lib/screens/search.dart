import 'package:daily_tasks/db/search_service.dart';
import 'package:daily_tasks/model/note.dart';
import 'package:flutter/material.dart';

import '../db/notes_database.dart';
import 'home.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Note>? notes;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    setState(() {
      refreshNotes();
    });
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    await NotesDatabase.instance.readAllNotes().then((value) => notes = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('bottom');
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(notes!),
              );
            },
            icon: Icon(
              Icons.search,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ],
        title: Text(
          'Search Notes',
          style: TextStyle(color: Theme.of(context).backgroundColor),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Container(),
    );
  }
}
