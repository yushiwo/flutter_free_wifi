// 附近Wi-Fi的数据model
class Wifi {
  String name;
  String intro;
  String address;
  double google_lat;
  double google_lon;
  double baidu_lat;
  double baidu_lon;
  double lat;
  double lon;
  String distance;

  Wifi(this.name, this.intro, this.address, this.google_lat, this.google_lon, this.baidu_lat, this.baidu_lon, this.lat, this.lon, this.distance);
}