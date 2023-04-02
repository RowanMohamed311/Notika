import 'package:daily_tasks/widgets/appbar.dart';
import 'package:daily_tasks/widgets/tiles.dart';
import 'package:flutter/material.dart';

class PrivateScreen extends StatefulWidget {
  PrivateScreen({Key? key}) : super(key: key);

  @override
  State<PrivateScreen> createState() => _PrivateScreenState();
}

class _PrivateScreenState extends State<PrivateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          Header(title: 'Private Notes', context: context, showLeading: true),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(child: TilesList(screen_flag: 2)),
    );
  }
}
