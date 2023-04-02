import 'package:daily_tasks/widgets/appbar.dart';
import 'package:daily_tasks/widgets/tiles.dart';
import 'package:flutter/material.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'Notika', context: context),
      backgroundColor: Theme.of(context).backgroundColor,
      body: const Center(
        child: TilesList(screen_flag: 3),
      ),
    );
  }
}
