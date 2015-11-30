library orm.adapters.mysql;

import 'dart:async';
import 'dart:collection';
import 'dart:mirrors';

import 'package:dapter/src/adapter.dart';
import 'package:dapter/src/config.dart';

LibraryMirror __library;

LibraryMirror get _library {
  if (__library == null) {
    try {
      __library = currentMirrorSystem().findLibrary(const Symbol('sqljocky'));
    } catch (_) {
      throw "Can't find library 'sqljocky'";
    }
  }
  return __library;
}

class MysqlAdapter extends Adapter {
  static ClassMirror _connectionPool =
      _library.declarations[const Symbol('ConnectionPool')];

  final dynamic _pool;

  MysqlAdapter(AdapterConfig config)
      : _pool = _connectionPool.newInstance(const Symbol(''), [], {
          const Symbol("host"): config.host,
          const Symbol("port"): config.port,
          const Symbol("user"): config.user,
          const Symbol("password"): config.password,
          const Symbol("db"): config.database
        }).reflectee;

  Future<Null> close() {
    return _pool.closeConnectionsNow();
  }

  Future<List> query(String sql) async {
    var result = await (await _pool.query(sql)).toList();
    return result.map((ListBase row) {
      var newRow = new List.from(row);
      for (var i = 0; i < newRow.length; i += 1) {
        if (newRow[i].runtimeType.toString() == "Blob") {
          newRow[i] = newRow[i].toString();
        }
      }
      return newRow;
    });
  }

  Future<int> insert(String sql) async {
    return (await _pool.query(sql)).insertId;
  }
}
