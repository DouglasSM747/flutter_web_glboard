import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/sidebar/sider_bar.dart';

class MainPage extends StatelessWidget {
  final String gameID;

  const MainPage(this.gameID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(gameID),
        appBar: AppBar(),
        body: Container(),
      );
}
