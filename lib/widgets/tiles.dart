import 'package:flutter/material.dart';
import '../db/notes_database.dart';
import '../model/note.dart';
import '../screens/note_detail.dart';

class TilesList extends StatefulWidget {
  final int screen_flag;
  const TilesList({Key? key, required this.screen_flag}) : super(key: key);

  @override
  State<TilesList> createState() => _TilesListState();
}

class _TilesListState extends State<TilesList> {
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
    if (widget.screen_flag == 0) {
      notes = await NotesDatabase.instance.readAllNotes();
    } else if (widget.screen_flag == 1) {
      notes = await NotesDatabase.instance.readImportantNotes();
    } else if (widget.screen_flag == 2) {
      notes = await NotesDatabase.instance.readPrivateNotes();
    } else if (widget.screen_flag == 3) {
      notes = await NotesDatabase.instance.readArchivedNotes();
    }

    setState(() => isLoading = false);
  }

  Future archieveNote(Note note) async {
    final note_archived = note.copy(
      isArchived: true,
    );
    await NotesDatabase.instance.update(note_archived);
  }

  Card cardOption(Note note) {
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
          refreshNotes();
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

  Widget _itemBuilder(BuildContext context, int index) {
    final note = notes![index];
    return widget.screen_flag == 0
        ? Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                archieveNote(note);
                notes!.removeAt(index);
              });
            },
            background: Container(
              color: const Color.fromARGB(150, 235, 167, 247),
            ),
            child: cardOption(note),
          )
        : cardOption(note);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : ListView.builder(
            // padding: EdgeInsets.all(5),
            itemBuilder: _itemBuilder,
            itemCount: notes!.length,
          );
  }
}
