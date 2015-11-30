library dapter.adapter;

import 'dart:async';
import 'package:dapter/src/config.dart';
import 'package:dapter/src/adapters/mysql_adapter.dart';

abstract class Adapter {
  Future<List<List>> query(String sql);
  Future<Null> close();
  Future<int> insert(String sql);

  Adapter();

  factory Adapter.build(AdapterConfig config) {
    if (config.dbType == "mysql") {
      return new MysqlAdapter(config);
    }
  }
}
