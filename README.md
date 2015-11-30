# dapter

A uniform interface to the database drivers in Dart.
Key feature - it doesn't have all of them in the dependencies, it uses mirrors to find them out.

Only supports [MySQL](https://pub.dartlang.org/packages/sqljocky) for now.

## Usage

A simple usage example:

```yaml
# pubspec.yaml
name: blah
dependencies:
  dapter: any
  sqljocky: any
```

```dart
// myapp.dart
import 'package:sqljocky/sqljocky.dart';
import 'package:dapter/dapter.dart';

main() async {
  var adapterConfig = new AdapterConfig(database: "mixbook_development_cp", dbType: "mysql");
  var adapter = new Adapter.build(adapterConfig);

  var result = await adapter.query("SELECT * FROM posts");
  print(result);
  adapter.close();
}
```

Please note that you **must** import `sqljocky`, even if you don't use it directly, so the mirrors
system in `dapter` could find it.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/astashov/dapter/issues
