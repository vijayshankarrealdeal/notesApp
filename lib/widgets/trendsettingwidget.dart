import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrendsSettingWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  TrendsSettingWidget({
    @required this.icon,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff0f3057),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: MediaQuery.of(context).size.height * 0.065,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Color(0xffe7e7de),
                size: 25.0,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontFamily: 'Lato-Regular'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
