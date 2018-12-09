import 'package:flutter/material.dart';
import 'package:flutter_free_wifi/modules/global/util/Util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global/model/wifi_model.dart';  // 导入model

class WifiDetailPage extends StatefulWidget {
  final Wifi wifi; //定义一个常量，用于保存跳转进来获取到的参数



  WifiDetailPage(this.wifi); //构造函数，获取参数

  @override
  _WifiDetailPageState createState() => _WifiDetailPageState();
}

class _WifiDetailPageState extends State<WifiDetailPage> {
  final String mUserName = "userName";
  final _userNameController = new TextEditingController();

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

  void _handleFavButtonClicked() {
//    save();
//
//    Future<String> userName = get();
//    userName.then((String userName) {
//      print("数据获取成功：$userName");
//    });


    Util.save(widget.wifi);

    Future<List<Wifi>> favWifiList = Util.getFavWifiList();
    favWifiList.then((List<Wifi> favWifiList){
      print("我的收藏内容是： " + favWifiList.toString());
    });

  }
}
