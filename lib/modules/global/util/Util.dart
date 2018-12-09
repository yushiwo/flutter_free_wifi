import 'package:flutter_free_wifi/modules/global/model/wifi_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static final String favWifiListKey = "fav_wifi_list";

  static List<Wifi> favWifiList = <Wifi>[];

  static void save(Wifi wifi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favWifiList.add(wifi);
    prefs.setString(favWifiListKey, favWifiList.toString());
  }

  static void remove(Wifi wifi) {

  }
  static Future<List<Wifi>> getFavWifiList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    favWifiList = prefs.getString(favWifiListKey);
    return favWifiList;
  }
}