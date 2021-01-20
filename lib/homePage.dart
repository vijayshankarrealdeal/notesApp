import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/addAndRead/add.dart';
import 'package:notes/addAndRead/home_app/DetailsOfHome.dart';
import 'package:notes/getDate.dart';
import 'package:notes/model/hoemDb.dart';
import 'package:notes/model/userdetails.dart';
import 'package:notes/services/database.dart';
import 'package:notes/widgets/error_dialog.dart';
import 'package:provider/provider.dart';
const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    final x = Provider.of<UserDetails>(context);
    final data = Provider.of<List<HomeDB>>(context);

    return Scaffold(
      backgroundColor:  colorSecondary,
      appBar: AppBar(
        backgroundColor: colorMain,
        leading: IconButton(icon: Icon(Icons.search),onPressed: ()=>showSearch(
          context: context,
          delegate: UserSearch(
              database: database, userList: data),
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: (){
              data.sort();
            }
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditorNew(
                        database: database,
                        x: x,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      body: Container(
        child: Container(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsOfHome(
                          database: database,
                          data: data[i],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(data[i].poster),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            stops: [0.5, 3.0],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            tileMode: TileMode.repeated,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                data[i].title,
                                style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.white,
                                    fontFamily: 'Lora-Regular'),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          getdate(data[i].time),
                                          style: TextStyle(
                                            fontFamily: 'Lora-Regular',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.white),
                                          onPressed: () => deltedialog(context,data[i].id,database)),
                                      IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          onPressed: (){
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => EditorNew(
                                                  idOfpost: data[i].id,
                                                  titlefromDraft: data[i].title,
                                                  draftText: data[i].content,
                                                  database: database,
                                                  x: x,
                                                ),
                                              ),
                                            );
                                          },),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class UserSearch extends SearchDelegate {
  final Database database;
  final List<HomeDB> userList;

  UserSearch({this.database, this.userList,});

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: colorMain,
      primaryIconTheme:
      theme.primaryIconTheme.copyWith(color: colorThird),
      primaryColorBrightness: Brightness.light,
      // ignore: deprecated_member_use
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
        // ignore: deprecated_member_use
        Theme.of(context).textTheme.title.copyWith(color: colorSecondary),
      ),
      // ignore: deprecated_member_use
      textTheme: TextTheme(
        // ignore: deprecated_member_use
        title: TextStyle(
          color: colorThird,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(CupertinoIcons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(CupertinoIcons.back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = userList
        .where((a) => a.title.toLowerCase().contains(query.toLowerCase()));
    return Container(
      color: CupertinoColors.white,
      child: ListView(
          children: result
              .map<Widget>(
                (e) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: colorMain,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  // onTap: () =>  Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => UserPageView(
                  //       database: database,
                  //
                  //     ),
                  //   ),
                  // ),

                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(e.poster),
                  ),
                  title: Text(
                    e.title,
                    style: TextStyle(
                      fontFamily: 'Lato-Light',
                      fontSize: 18.0,
                      color: colorThird,
                    ),
                  ),
                ),
              ),
            ),
          )
              .toList()),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = userList.where((a) => a.title.toLowerCase().contains(query));
    return Container(
      color: CupertinoColors.white
      ,
      child: ListView(
          children: result
              .map<Widget>(
                (e) => Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: colorMain,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ListTile(
                  onTap: () => {
                   // Navigator.push(
                   //    context,
                   //    MaterialPageRoute(
                   //      builder: (context) =>
                   //    ),
                   //  ),
                   //
                  },
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(e.poster),
                  ),
                  title: Text(
                    e.title,
                    style: TextStyle(
                      fontFamily: 'Lato-Bold',
                      fontSize: 18.0,
                      color: colorThird,
                    ),
                  ),
                ),
              ),
            ),
          )
              .toList()),
    );
  }
}
