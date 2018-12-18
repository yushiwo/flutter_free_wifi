// 附近Wi-Fi的数据model

import 'package:sqflite/sqflite.dart';

final String tableName = "fav_wifi_list";   // 收藏的wifi列表

final String columnId = '_id';
final String columnName = 'name';
final String columnIntro = 'intro';
final String columnAddress = 'address';
final String columnGoogleLat = 'google_lat';
final String columnGoogleLon = 'google_lon';
final String columnBaiduLat = 'baidu_lat';
final String columnBaiduLon = 'baidu_lon';
final String columnLat = 'lat';
final String columnLon = 'lon';
final String columnDistance = 'distance';

class Wifi {
  String name;
  String intro;
  String address;
  String google_lat;
  String google_lon;
  String baidu_lat;
  String baidu_lon;
  String lat;
  String lon;
  int distance;

  int id;

  Wifi(this.name, this.intro, this.address, this.google_lat, this.google_lon, this.baidu_lat, this.baidu_lon, this.lat, this.lon, this.distance);

  @override
  String toString() {
    return 'Wifi{name: $name, intro: $intro, address: $address, google_lat: $google_lat, google_lon: $google_lon, baidu_lat: $baidu_lat, baidu_lon: $baidu_lon, lat: $lat, lon: $lon, distance: $distance}';
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnIntro: intro,
      columnAddress: address,
      columnGoogleLat: google_lat,
      columnGoogleLon: google_lon,
      columnBaiduLat: baidu_lat,
      columnBaiduLon: baidu_lon,
      columnLat: lat,
      columnLon: lon,
      columnDistance: distance
    };
    
    return map;
  }

  Wifi.fromMap(Map<String, dynamic> map) {
    name = map[columnName];
    intro = map[columnIntro];
    address = map[columnAddress];
    google_lat = map[columnGoogleLat];
    google_lon = map[columnGoogleLon];
    baidu_lat = map[columnBaiduLat];
    baidu_lon = map[columnBaiduLon];
    lat = map[columnLat];
    lon = map[columnLon];
    distance = map[columnDistance];
  }

}

class WifiProvider {
  Database db;

  Future<WifiProvider> open() async {

    var path = await getDatabasesPath();

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableName ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnIntro text not null,
  $columnAddress text not null,
  $columnGoogleLat text not null,
  $columnGoogleLon text not null,
  $columnBaiduLat text not null,
  $columnBaiduLon text not null,
  $columnLat text,
  $columnLon text,
  $columnDistance integer not null)
''');
        });

    return this;
  }


  Future open1() async {

    var path = await getDatabasesPath();

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableName ( 
  $columnId integer primary key autoincrement, 
  $columnName text not null,
  $columnIntro text not null,
  $columnAddress text not null,
  $columnGoogleLat text not null,
  $columnGoogleLon text not null,
  $columnBaiduLat text not null,
  $columnBaiduLon text not null,
  $columnLat text,
  $columnLon text,
  $columnDistance integer not null)
''');
        });
  }

  Future<Wifi> insert(Wifi wifi) async {
    wifi.id = await db.insert(tableName, wifi.toMap());
    return wifi;
  }

  Future<Wifi> getWifi(int id) async {
    List<Map> maps = await db.query(tableName,
        columns: [columnId, columnName, columnIntro, columnAddress, columnGoogleLat, columnGoogleLon,
        columnBaiduLat, columnBaiduLon, columnLat, columnLon, columnDistance],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      print("maps.length = " + maps.length.toString());
      return Wifi.fromMap(maps.first);
    }
    return null;
  }

  Future<Wifi> getFirstWifi() async {
    List<Map> maps = await db.query(tableName,
        columns: [columnId, columnName, columnIntro, columnAddress, columnGoogleLat, columnGoogleLon,
        columnBaiduLat, columnBaiduLon, columnLat, columnLon, columnDistance]);
    if (maps.length > 0) {
      print("maps.length = " + maps.length.toString());
      return Wifi.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Wifi>> getAllWifis() async {
    List<Map> maps = await db.query(tableName,
        columns: [columnId, columnName, columnIntro, columnAddress, columnGoogleLat, columnGoogleLon,
        columnBaiduLat, columnBaiduLon, columnLat, columnLon, columnDistance]);
    if (maps.length > 0) {
      List<Wifi> result = new List();
      for(int i = 0; i < maps.length; i++) {
        result.add(Wifi.fromMap(maps[i]));
      }
      print("maps.length = " + maps.length.toString());
      return result;
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Wifi wifi) async {
    return await db.update(tableName, wifi.toMap(),
        where: '$columnId = ?', whereArgs: [wifi.id]);
  }

  Future close() async => db.close();
}