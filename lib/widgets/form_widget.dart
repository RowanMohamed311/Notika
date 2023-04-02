import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final bool? isImportant;
  final bool? isPrivate;
  final bool? isArchived;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<bool> onChangedPrivate;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback? AddOREdit;

  const FormWidget({
    Key? key,
    this.isImportant = false,
    this.isPrivate = false,
    this.isArchived = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedPrivate,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.AddOREdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width * 0.99,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),

                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('bottom');
                    },
                    // color: Colors.black54,
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: 40,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 60,
                        child: FloatingActionButton.extended(
                          // heroTag: 'expand_save',
                          elevation: 2,
                          onPressed: AddOREdit,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 245, 225),
                          foregroundColor: Theme.of(context).accentColor,
                          label: const Text('Save'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          onChangedImportant(!isImportant!);
                        },
                        icon: isImportant!
                            ? const Icon(
                                Icons.star,
                                // size: 30,
                              )
                            : const Icon(
                                Icons.star_border,
                                // size: 30,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          onChangedPrivate(!isPrivate!);
                        },
                        icon: isPrivate!
                            ? const Icon(
                                Icons.private_connectivity_rounded,
                                // size: 30,
                              )
                            : const Icon(
                                Icons.private_connectivity_outlined,
                                // size: 30,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Title(),
            const SizedBox(
              height: 10,
            ),
            Description(),
          ],
        ),
      ),
    );
  }

  Widget Title() => TextFormField(
        maxLines: 1,
        initialValue: title,
        decoration: const InputDecoration(
          hintText: 'Title',
          border: InputBorder.none,
          filled: true,
          fillColor: Color.fromARGB(255, 151, 148, 180),
          focusColor: Colors.white,
          hoverColor: Colors.white,
        ),
        onChanged: onChangedTitle,
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
      );

  Widget Description() => TextFormField(
        maxLines: 20,
        initialValue: description,
        decoration: const InputDecoration(
          hintText: 'Type Something.....',
          border: InputBorder.none,
          filled: true,
          fillColor: Color.fromARGB(255, 151, 148, 180),
          focusColor: Colors.white,
          hoverColor: Colors.white,
        ),
        onChanged: onChangedDescription,
        validator: (description) => description != null && description.isEmpty
            ? 'The description cannot be empty'
            : null,
      );
}
