import 'package:flutter/material.dart';
import 'package:muif_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = 'Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: TitleText(
            color: Theme.of(context).colorScheme.secondary,
            size: 30,
            text: 'MUIF APP',
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        drawer: const SideMenu(),
      ),
    );
  }
}
