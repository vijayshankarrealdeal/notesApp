import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);

class TextForms extends StatelessWidget {
  final String placeholder;
  final bool hide;
  final TextEditingController enter;
  final double left;
  final double right;
  final bool isspin;
  TextForms(
      {@required this.placeholder,
      this.left = 20,
      this.right = 20,
      @required this.hide,
      this.isspin = true,
      @required this.enter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      child: Padding(
        padding: EdgeInsets.only(left: left, right: right),
        child: CupertinoTextField(
          enabled: isspin,
          style: TextStyle(color: CupertinoColors.white),
          decoration: BoxDecoration(
              color: colorMain,
              borderRadius: BorderRadius.circular(5.0)),
          placeholderStyle: TextStyle(color: colorSecondary),
          controller: enter,
          obscureText: hide,
          placeholder: placeholder,
          prefix: SizedBox(height: 5.0),
        ),
      ),
    );
  }
}
