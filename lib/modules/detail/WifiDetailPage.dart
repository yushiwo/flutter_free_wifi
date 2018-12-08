import 'package:flutter/material.dart';
import '../global/model/wifi_model.dart';  // 导入model


class WifiDetailPage extends StatefulWidget {
  final Wifi wifi; //定义一个常量，用于保存跳转进来获取到的参数

  WifiDetailPage(this.wifi); //构造函数，获取参数

  @override
  _WifiDetailPageState createState() => _WifiDetailPageState();
}

class _WifiDetailPageState extends State<WifiDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wifi.name),
      ),

    );
  }
}
