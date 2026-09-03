import 'web_stub.dart' if (dart.library.js_interop) 'web_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/api_datasource.dart';
import 'package:todo_list/services/data_source.dart';
import 'package:todo_list/services/hive_data_source.dart';
import 'package:todo_list/services/sqlite_data_source.dart';

class DataServiceManager extends DataSource {
  late final DataSource _local;
  late final DataSource _remote;

  static Future<DataServiceManager> createAsync() async {
    final manager = DataServiceManager();
    manager._local = kIsWeb
        ? await HiveDataSource.createAsync()
        : await SqliteDataSource.createAsync();
    manager._remote = await APIDataSource.createAsync();
    return manager;
  }

  Future<bool> _checkConnectivity() async {
    if ((kIsWeb && isWebOffline() == false)) return false;

    List<ConnectivityResult> connectionResult = await Connectivity()
        .checkConnectivity();

    if (connectionResult.contains(ConnectivityResult.none)) return false;
    return true;
  }

  @override
  Future<bool> add(Todo model) async {
    if (await _checkConnectivity()) {
      _remote.add(model);
      return true;
    }

    _local.add(model);
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    if (await _checkConnectivity()) {
      return _remote.browse();
    }

    return _local.browse();
  }

  @override
  Future<bool> delete(Todo model) async {
    if (await _checkConnectivity()) {
      _remote.delete(model);
      return true;
    }

    _local.delete(model);
    return true;
  }

  @override
  Future<bool> edit(Todo model) async {
    if (await _checkConnectivity()) {
      _remote.edit(model);
      return true;
    }

    _local.edit(model);
    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    if (await _checkConnectivity()) {
      return _remote.read(id);
    }

    return _local.read(id);
  }
}
