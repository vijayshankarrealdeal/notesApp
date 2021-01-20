import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/addAndRead/home_app/detailsOfHomeHeader.dart';
import 'package:notes/getDate.dart';
import 'package:notes/model/hoemDb.dart';
import 'package:notes/services/database.dart';
import 'package:zefyr/zefyr.dart';
const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
class DetailsOfHome extends StatelessWidget {
  final HomeDB data;
  final Database database;

  DetailsOfHome({Key key, this.database, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List s = [
      data.content,
    ];

    NotusDocument _loadDrafts(String json) {
      return NotusDocument.fromJson(jsonDecode(json));
    }
    return Scaffold(
      backgroundColor: colorSecondary,
      appBar: CupertinoNavigationBar(
        backgroundColor: colorMain,
        actionsForegroundColor: colorThird,
      ),
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: NetworkingPageHeader(
            minExtent: 250.0,
            maxExtent: 400.0,
            x: data,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 70.0,
          delegate: SliverChildListDelegate(
            [
              Container(
                color: colorMain,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.0),
                          Text(
                            'Created ${getdate(data.time)}',
                            style: TextStyle(
                                fontFamily: 'Lato-Regular',
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: CupertinoColors.white),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'On ${dateXX(data.time)}',
                            style: TextStyle(
                                fontFamily: 'Lato-Regular',
                                fontSize: 12.0,
                                color: CupertinoColors.white),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, i) {
            return Container(
              color: colorSecondary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                ZefyrTheme(
                  data: ZefyrThemeData(
                    attributeTheme: AttributeTheme(
                      heading1: LineTheme(
                        padding: EdgeInsets.all(1),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.white
                          ,),
                      ),
                      heading2: LineTheme(
                        padding: EdgeInsets.all(1),
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      heading3: LineTheme(
                        padding: EdgeInsets.all(1),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.white,
                        ),),
                      link: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,


                      ),
                      bold: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,

                        color: colorThird,
                      ),
                      bulletList: BlockTheme(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: colorThird,
                        ),
                      ),
                      quote: BlockTheme(
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,

                          color: colorThird,
                        ),
                      ),

                    ),
                    defaultLineTheme: LineTheme(
                      padding: EdgeInsets.all(1),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: colorThird,),
                    ),
                  ),
                  child: ZefyrView(
                    document: _loadDrafts(s[i]),
                  ),
                ),


              ),
            );
          }, childCount: s.length),
        ),
      ]),
    );
  }
}