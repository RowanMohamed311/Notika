import 'package:daily_tasks/db/notes_database.dart';
import 'package:daily_tasks/model/note.dart';
import 'package:daily_tasks/screens/bottom_nav.dart';

import 'package:daily_tasks/screens/record_notes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: slash_for_doc_comments

class NoteDetailPage extends StatefulWidget {
  final Note note;
  const NoteDetailPage({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  bool isLoading = false;
  // late Note note;

  @override
  void initState() {
    super.initState();
  }

  Future refreshNote() async {
    // setState(() => isLoading = true);

    // this.note = await NotesDatabase.instance.readNote(widget.noteid);

    // setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
              (Route<dynamic> route) => false,
            );
          },
          color: Colors.black54,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (isLoading) return;
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => RecordNotes(note: widget.note)),
                (Route<dynamic> route) => false,
              );
              refreshNote();
            },
            icon: const Icon(
              Icons.edit,
              // size: 30,
            ),
          ),
          IconButton(
              onPressed: () async {
                await NotesDatabase.instance.delete(widget.note.id);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.delete_outline,
                // size: 30,
              )),
        ],
        title: const Text("Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Text(
                widget.note.title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Text(
                  widget.note.description,
                  maxLines: 50,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Modified time: ' +
                          DateFormat.yMMMd().format(widget.note.modifiedTime),
                      style: const TextStyle(color: Colors.black45),
                    ),
                    Text(
                      'Created time: ' +
                          DateFormat.yMMMd().format(widget.note.createdTime),
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
