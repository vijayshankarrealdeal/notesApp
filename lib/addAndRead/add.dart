import 'dart:convert';
import 'package:notes/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/model/hoemDb.dart';
import 'package:notes/model/userdetails.dart';
import 'package:notes/services/database.dart';
import 'package:notes/widgets/error_dialog.dart';
import 'package:notes/widgets/textForm.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);

class EditorNew extends StatefulWidget {
  final String idOfpost;
  final String draftText;
  final Database database;
  final UserDetails x;
  final String titlefromDraft;

  const EditorNew(
      {Key key,
      this.x,
        this.idOfpost,
      this.titlefromDraft,
      this.database,
      this.draftText})
      : super(key: key);
  @override
  _EditorNewState createState() => _EditorNewState();
}

class _EditorNewState extends State<EditorNew> {
  bool isspin = true;
  ZefyrController _controller;
  //ZefyrController _controller2;

  FocusNode _focusNode;
  String timeX = DateTime.now().toString();
  DateTime id = DateTime.now();
  final FirebaseStorage storage = FirebaseStorage.instance;
  UploadTask _uploadTask;
  String media;
  String p;


  ///init State
  @override
  void initState() {
    _title.text = widget.titlefromDraft;
    _controller = _title.text.isEmpty
        ? ZefyrController(_loadDocument())
        : ZefyrController(_loadDrafts());
    _focusNode = FocusNode();
    super.initState();
  }

  TextEditingController _title = TextEditingController();

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert(" \n");
    return NotusDocument.fromDelta(delta);
  }

  NotusDocument _loadDrafts() {
    return NotusDocument.fromJson(jsonDecode(widget.draftText));
  }

  Future<String> startUploadI(CameraAndFile image) async {
    String filePath = '${DateTime.now().microsecondsSinceEpoch}.png';
    setState(() {
      Reference ref = storage.ref().child(filePath);
       _uploadTask = ref.putFile(image.resource);
    });
    var downloadUrl = await (await _uploadTask).ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> submit(CameraAndFile imageFnT) async {
    setState(() {
      isspin = false;
    });
    try {
      if (_title.text.isEmpty || _title.text.length > 20) {
        setState(() {
          isspin = true;
        });
        dialog(context,
            'You Must Add a title or title must be less than 20 character');
      } else if (imageFnT.resource == null) {
        setState(() {
          isspin = true;
        });
        dialog(context, 'Add a Image');
      } else {
        await imageFnT.compressImage(id.toString());
        media = await startUploadI(imageFnT);
        p = media;
        final DateTime t = DateTime.now();
        await widget.database.createPost(
          postID: timeX.toString(),
          data: HomeDB(
            poster: "$p",
            id: timeX.toString(),
            content: jsonEncode(_controller.document).toString(),
            title: _title.text.trim(),
            time: t.toString(),
            user: {
              'uid': widget.x.uid,
              'email': widget.x.email,
            },
          ),
        );

        Navigator.pop(context);
        setState(() {
          imageFnT.resource = null;
        });
      }
    } catch (e) {
      setState(() {
        isspin = true;
      });
      print(e);
      // dialog(context,print(e));
    }
  }
  @override
  Widget build(BuildContext context) {
    final imageFunctions = Provider.of<CameraAndFile>(context);
    return Scaffold(
      backgroundColor: colorMain,
      appBar: AppBar(
        automaticallyImplyLeading: isspin,
        backgroundColor: colorMain,
        actions: isspin
            ? [
             widget.titlefromDraft != null?  IconButton(
                    icon: Icon(Icons.save, color: colorThird),
                    onPressed: () async {
                      await widget.database.updatePost(postID: widget.idOfpost,data: jsonEncode(_controller.document).toString());
                    Navigator.pop(context);
                    }):Text(''),
                IconButton(
                    icon: Icon(CupertinoIcons.check_mark, color: colorThird),
                    onPressed: () async {
                      await submit(imageFunctions);
                      // _saveDocument(context);
                      // await  submit(imageFunctions);
                    }),
             ]
            : CupertinoActivityIndicator(),
      ),
      body: Scaffold(
        backgroundColor: colorSecondary,
        body: ZefyrScaffold(
          child: ListView(
            children: [
              Container(
                child: Container(
                  //margin: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    children: [
                      imageFunctions.resource == null
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: FlatButton.icon(
                                onPressed: () => imageFunctions.showListI(
                                  context,
                                  imageFunctions,
                                ),
                                icon: Icon(
                                  CupertinoIcons.add_circled,
                                  size: 30.0,
                                  color: colorMain,
                                ),
                                label: Text(
                                  'Add Image',
                                  style: TextStyle(
                                    color: colorThird,
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      image: DecorationImage(
                                        image:
                                            FileImage(imageFunctions.resource),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          //color: Colors.white,
                                          height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                          child: IconButton(icon: Icon(CupertinoIcons.clear_circled,
                                            size: 35,
                                            color: colorThird,
                                          ),
                                              onPressed: () {
                                                imageFunctions.removeImageI();

                                              }),),
                                      ),
                                    ),
                                    ),

                                  ),
                              ],
                            ),
                      TextForms(
                        isspin: isspin,
                        left: 8,
                        right: 8,
                        hide: false,
                        enter: _title,
                        placeholder: 'Title',
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.0),
                              topLeft: Radius.circular(8.0),
                            ),
                            color: CupertinoColors.white,
                          ),
                          height: MediaQuery.of(context).size.height,
                          child: ZefyrEditor(
                            padding: EdgeInsets.all(4),
                            controller: _controller,
                            focusNode: _focusNode,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
