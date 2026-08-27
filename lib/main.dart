import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/services/data_source.dart';
import 'package:todo_list/services/sqlite_data_source.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.putAsync<DataSource>(
    () => SqliteDataSource.createAsync(),
  ).whenComplete(() => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TodoScreen());
  }
}
