import 'package:daily_tasks/widgets/appbar.dart';
import 'package:daily_tasks/widgets/tiles.dart';
import 'package:flutter/material.dart';

class ImportantScreen extends StatefulWidget {
  ImportantScreen({Key? key}) : super(key: key);

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: "Notika", context: context),
      backgroundColor: Theme.of(context).backgroundColor,
      body: const Center(
        child: TilesList(screen_flag: 1),
      ),
    );
  }
}
