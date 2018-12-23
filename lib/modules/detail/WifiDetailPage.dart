import 'package:amap_location/amap_location.dart';
import 'package:amap_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/model/wifi_model.dart';  // 导入model

import 'package:simple_permissions/simple_permissions.dart';
import 'package:easy_alert/easy_alert.dart';

// 标题栏：标题，收藏和取消收藏按钮
// wifi名称
// wifi详情信息
// 点击导航：toast提示待开发
//

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
          new IconButton(icon: const Icon(Icons.favorite), onPressed: handleSave),
        ],
      ),

      body: _refreshPage(widget.wifi),

    );
  }

  Widget _refreshPage(Wifi wifi) {

    return new Container(
      padding: const EdgeInsets.all(32.0),
      // 名字和地址
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    wifi.name,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new Text(
                      wifi.address,
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButtonColumn(Icons.near_me, 'ROUTE'),
                    buildButtonColumn(Icons.share, 'SHARE'),
                  ],
                ),
                
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("其他信息"),
                    new Text(wifi.intro)
                  ],
                )
              ],
            ),
          ),
        ],
      ),

    );
  }

  Column buildButtonColumn(IconData icon, String label) {
    Color color = Theme.of(context).primaryColor;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
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



  void handleSave() async {
    List notes;
    var db = new WifiDatabaseHelper();

    await db.saveNote(widget.wifi);
    await db.saveNote(widget.wifi);
    await db.saveNote(widget.wifi);
    await db.saveNote(widget.wifi);

    print('=== getAllNotes() ===');
    notes = await db.getAllNotes();
    notes.forEach((note) => print(note));

    int count = await db.getCount();
    print('Count: $count');

    print('=== getNote(1) ===');
    Wifi note = await db.getNote(1);
//    print(note.toMap());

    notes = await db.getAllNotes();
    notes.forEach((note) => print(note));

//    print('=== deleteNote(1) ===');
//    await db.deleteNote(1);
//    notes = await db.getAllNotes();
//    notes.forEach((note) => print(note));

//    await db.close();
  }

}
