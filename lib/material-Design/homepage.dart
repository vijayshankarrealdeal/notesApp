

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/account.dart';
import 'package:notes/homePage.dart';
import 'package:notes/material-Design/bottomNavigationBar.dart';
import 'package:notes/material-Design/change.dart';
import 'package:provider/provider.dart';


class MaterialHomePage extends StatelessWidget {
  final List<Widget> children = [
    HomePage(),
    Account(),

  ];

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<ChangeofPage>(context);
    return Scaffold(
      body: children[nav.pageIndex],
      bottomNavigationBar: MaterialBottomNavigationBar(),
    );
  }
}
