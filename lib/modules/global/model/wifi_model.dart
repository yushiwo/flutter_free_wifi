// 附近Wi-Fi的数据model
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

  Wifi(this.name, this.intro, this.address, this.google_lat, this.google_lon, this.baidu_lat, this.baidu_lon, this.lat, this.lon, this.distance);

  @override
  String toString() {
    return 'Wifi{name: $name, intro: $intro, address: $address, google_lat: $google_lat, google_lon: $google_lon, baidu_lat: $baidu_lat, baidu_lon: $baidu_lon, lat: $lat, lon: $lon, distance: $distance}';
  }


}