import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/data_source.dart';

class APIDataSource implements DataSource {
  late FirebaseDatabase database;

  Future initalise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    database = FirebaseDatabase.instance;
  }

  static Future<APIDataSource> createAsync() async {
    APIDataSource dataSource = APIDataSource();
    await dataSource.initalise();
    return dataSource;
  }

  @override
  Future<bool> add(Todo model) async {
    final DatabaseReference newDoc = database.ref('todos').push();

    await newDoc.set({
      'id': newDoc.key,
      'name': model.title,
      'description': model.description,
      'complete': model.isComplete,
    });

    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    final DataSnapshot snapshot = await database.ref('todos').get();
    if (!snapshot.exists) {
      throw Exception(
        'Invalid Request - Cannot find snapshot: ${snapshot.ref.path}',
      );
    }
    final todoMap = Map<String, dynamic>.from(snapshot.value as Map);

    final returnMap = todoMap.entries.map((e) {
      final innerMap = Map<String, dynamic>.from(e.value);
      innerMap['id'] = e.key;
      innerMap['title'] = e.value['name'];
      return Todo.fromMap(innerMap);
    }).toList();

    return returnMap;
  }

  @override
  Future<bool> delete(Todo model) async {
    await database.ref('todos').child(model.id).remove();
    return true;
  }

  @override
  Future<bool> edit(Todo model) async {
    await database.ref('todos').child(model.id).update({
      'name': model.title,
      'description': model.description,
      'complete': model.isComplete,
    });
    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    DataSnapshot doc = await database.ref('todos').child(id).get();
    final docMap = Map<String, dynamic>.from(doc.value as Map);
    return Todo(
      id: doc.key.toString(),
      title: docMap['name'],
      isComplete: docMap['complete'],
      description: docMap['description'],
    );
  }
}
