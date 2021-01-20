import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/model/userdetails.dart';
import 'package:notes/services/auth.dart';
import 'package:notes/widgets/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final x = Provider.of<UserDetails>(context);
    final auth = Provider.of<AuthBase>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: colorMain,),
        body: Container(color: colorSecondary,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:CachedNetworkImageProvider('https://blog.tofte-it.dk/wp-content/uploads/2018/12/profile-picture.png'),
               radius: 60,
              ),
              SizedBox(height: 20,),
              Text('${x.email}',style: TextStyle(fontSize: 22.0,color: colorThird),),
              SizedBox(height: 20,),
              CupertinoButton(
                color: colorMain,

                child: Text('Logout'),onPressed: ()=>logoutdialogX(context,auth),)
          ],),
        ),),
      ),
    );
  }
}
