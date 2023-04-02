import 'package:flutter/material.dart';

import '../model/note.dart';
import '../screens/note_detail.dart';
import 'notes_database.dart';

//! important to revise the concept of search again.
class CustomSearchDelegate extends SearchDelegate<Note> {
  List<Note> items = [];
  List<Note> suggestion = [];
  int? len;
  CustomSearchDelegate(this.items);

  Card cardOption(BuildContext context, Note note) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 0,
      color: Theme.of(context).accentColor,
      child: ListTile(
        textColor: const Color.fromARGB(255, 255, 250, 236),
        minVerticalPadding: 20,
        style: ListTileStyle.drawer,
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NoteDetailPage(note: note),
            ),
          );
        },
        // contentPadding: EdgeInsets.only(top: 10, bottom: 10),
        title: Text(
          note.title,
          style: Theme.of(context).textTheme.headline3,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: true,
          ),
        ),
        subtitle: Text(
          note.description,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        trailing: SizedBox(
          height: 100,
          width: 25,
          child: Row(
            children: <Widget>[
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: note.isImportant
                      ? const Icon(
                          Icons.star,
                        )
                      : const Icon(
                          Icons.star_border,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final suggestion = query.isEmpty
        ? items
        : items.where((element) => element.title.contains(query)).toList();
    if (items.isEmpty) {
      return Container(
        child: const Center(
          child: Text('EMPTY'),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return cardOption(context, suggestion[index]);
        },
        itemCount: suggestion.length,
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? items
        : items.where((element) => element.title.contains(query)).toList();
    if (items.isEmpty) {
      return Container(
        child: const Center(
          child: Text('EMPTY'),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return cardOption(context, suggestion[index]);
        },
        itemCount: suggestion.length,
      );
    }
  }
}
