import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/model/hoemDb.dart';
import 'package:notes/model/userdetails.dart';

abstract class Data {
  Future<void> createUser({UserDetails create});
  Future<void> createPost({String postID, HomeDB data});
  Future<void> deletePost({String postID});
  Future<void> updatePost({String postID,String data});
  Stream userStream();
  Stream<List<HomeDB>> notesStream();
}

class Database extends Data {
  final String uid;
  final String email;
  Database({this.uid, this.email});
  final _refrence = FirebaseFirestore.instance;

  //users
  @override
  Future<void> createUser({UserDetails create}) async {
    final path = '/users/$uid';
    await _refrence.doc(path).set(create.toJson());
  }
  @override
  Future<void> createPost({String postID, HomeDB data}) async {
    final path = '/users/$uid/userData/$postID';
    await _refrence.doc(path).set(data.toMap());
  }

  @override
  Future<void> deletePost({String postID}) async {
    final path = '/users/$uid/userData/$postID';
    await _refrence.doc(path).delete();
  }
  @override
  Future<void> updatePost({String postID,String data}) async {
    final path = '/users/$uid/userData/$postID';
    await _refrence.doc(path).update({'content':data});
  }

  @override
  Stream<List<UserDetails>> userStream() {
    return _refrence.collection('users').snapshots().map((event) =>
        event.docs.map((e) => UserDetails.fromJson(e.data())).toList());
  }
  @override
  Stream<List<HomeDB>> notesStream() {
    return _refrence.collection('users').doc('$uid').collection('userData').snapshots().map((event) =>
        event.docs.map((e) => HomeDB.fromJson(e.data())).toList());
  }
}
