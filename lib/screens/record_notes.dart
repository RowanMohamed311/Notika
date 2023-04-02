import 'package:daily_tasks/db/notes_database.dart';
import 'package:daily_tasks/model/note.dart';
import 'package:daily_tasks/screens/bottom_nav.dart';
import 'package:daily_tasks/screens/home.dart';
import 'package:daily_tasks/screens/notes_page.dart';
import 'package:daily_tasks/widgets/form_widget.dart';
import 'package:flutter/material.dart';
// ignore: slash_for_doc_comments

class RecordNotes extends StatefulWidget {
  final Note? note;
  const RecordNotes({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<RecordNotes> createState() => _RecordNotesState();
}

class _RecordNotesState extends State<RecordNotes> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late bool isPrivate;
  late bool isArchived;
  late int number;
  late String title;
  late String description;
  @override
  void initState() {
    super.initState();
    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    isPrivate = widget.note?.isPrivate ?? false;
    isArchived = widget.note?.isArchived ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).accentColor,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: FormWidget(
              description: description,
              isImportant: isImportant,
              isPrivate: isPrivate,
              number: number,
              title: title,
              isArchived: isArchived,
              onChangedImportant: (isImportant) =>
                  setState(() => this.isImportant = isImportant),
              onChangedNumber: (number) => setState(() => this.number = number),
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onChangedPrivate: (isPrivate) =>
                  setState(() => this.isPrivate = isPrivate),
              AddOREdit: addOrEdit,
            ),
          ),
        ),
      ),
    );
  }

  void addOrEdit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.note != null;
      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigation()),
      (Route<dynamic> route) => false,
    );
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      isPrivate: isPrivate,
      isArchived: isArchived,
      description: description,
      modifiedTime: DateTime.now(),
      title: title,
      number: number,
    );
    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      isImportant: isImportant,
      isPrivate: isPrivate,
      isArchived: isArchived,
      description: description,
      createdTime: DateTime.now(),
      modifiedTime: DateTime.now(),
      title: title,
      number: number,
    );
    await NotesDatabase.instance.create(note);
  }
}
