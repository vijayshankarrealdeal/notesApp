import 'package:flutter/cupertino.dart';
const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
class ChangeofPage extends ChangeNotifier {
  int pageIndex = 0;
  final double size = 30;
  final Color navbackground = colorMain;
  final Color color =
      colorThird;
  void kCallback(int index) {
    pageIndex = index;
    notifyListeners();
  }
}
