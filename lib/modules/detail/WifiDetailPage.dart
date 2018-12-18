import 'package:amap_location/amap_location.dart';
import 'package:amap_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/model/wifi_model.dart';  // 导入model

import 'package:simple_permissions/simple_permissions.dart';
import 'package:easy_alert/easy_alert.dart';

class WifiDetailPage extends StatefulWidget {
  final Wifi wifi; //定义一个常量，用于保存跳转进来获取到的参数



  WifiDetailPage(this.wifi); //构造函数，获取参数

  @override
  _WifiDetailPageState createState() => _WifiDetailPageState();
}

class _WifiDetailPageState extends State<WifiDetailPage> {
  final String mUserName = "userName";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详细信息"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.favorite), onPressed: _handleFavButtonClicked),
        ],
      ),

      body: new Text(
        "Text"
      ),

    );
  }


  save() async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((SharedPreferences preference){
      preference.setString(mUserName, "123");
    });
  }

  Future<String> get() async {
    var userName;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(mUserName);
    return userName;
  }

  Future _handleFavButtonClicked() async {
//    save();
//
//    Future<String> userName = get();
//    userName.then((String userName) {
//      print("数据获取成功：$userName");
//    });


//    Util.save(widget.wifi);
//
//    Future<List<Wifi>> favWifiList = Util.getFavWifiList();
//    favWifiList.then((List<Wifi> favWifiList){
//      print("我的收藏内容是： " + favWifiList.toString());
//    });


//    WifiProvider wifiProvider = new WifiProvider();
//    try {
//      Future<WifiProvider> p = wifiProvider.open();
//      p.then((WifiProvider pp) {
//        Future<Wifi> w1 = pp.insert(widget.wifi);
//        w1.then((Wifi wifi) {
//          print("111 = " + wifi.toString());
//        });
//
//        Future<List<Wifi>> w2 = pp.getAllWifis();
//        w2.then((List<Wifi> wifis) {
//          print("取出 = " + wifis.toString());
//        });
//      });
//    } catch (Exception) {}
    _checkPersmission();

    await AMapLocationClient.startup(new AMapLocationOption( desiredAccuracy:CLLocationAccuracy.kCLLocationAccuracyHundredMeters ));
    await AMapLocationClient.getLocation(true);
  }


  void _checkPersmission() async{
    bool hasPermission = await SimplePermissions.checkPermission(Permission.WhenInUseLocation);
    if(!hasPermission){
      var requestPermissionResult = (await SimplePermissions.requestPermission(Permission.WhenInUseLocation)) as bool;
      if(!requestPermissionResult){
        Alert.alert(context,title: "申请定位权限失败");
        return;
      }
    }

    AMapLocationClient.startLocation();
  }

}
