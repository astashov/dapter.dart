library dapter.adapter_config;

class AdapterConfig {
  final String dbType;
  final String host;
  final String user;
  final String password;
  final int port;
  final String database;

  AdapterConfig(
      {this.dbType: "mysql",
      this.host: "localhost",
      this.user: "root",
      this.password,
      this.port: 3306,
      this.database}) {
    if (database == null) {
      throw "You must specify the 'database' option with the database name\n";
    }
  }
}
