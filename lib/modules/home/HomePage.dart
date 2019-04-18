import 'package:flutter/material.dart';
import 'package:flutter_free_wifi/modules/about/AboutPage.dart';
import 'package:flutter_free_wifi/modules/detail/WifiDetailPage.dart';
import 'package:flutter_free_wifi/modules/fav/FavListPage.dart';
import 'package:flutter_free_wifi/modules/global/model/wifi_model.dart';
import './NearbyListPage.dart';

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Free Wi-Fi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '附近的Wi-Fi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      drawer: _buildDrawer(),  // 侧边栏

      body: new NearbyListPage(),  // 主页
    );
  }

  // 抽屉布局
  Widget _buildDrawer() {
    return new Drawer(     //侧边栏按钮Drawer
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(   //Material内置控件
            accountName: new Text('ZR'), //用户名
            accountEmail: new Text('zhengrui504@163.com'),  //用户邮箱
            currentAccountPicture: new GestureDetector( //用户头像
              onTap: () => print('current user'),
              child: new CircleAvatar(    //圆形图标控件
                backgroundImage: new NetworkImage('https://avatars0.githubusercontent.com/u/6859852?s=460&v=4'),//图片调取自网络
              ),
            ),
            decoration: new BoxDecoration(    //用一个BoxDecoration装饰器提供背景图片
              image: new DecorationImage(
                fit: BoxFit.fill,
                // image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
                //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
                image: new ExactAssetImage('images/lake.jpg'),
              ),
            ),
          ),
          new ListTile(   //第一个功能项（测试页）
              title: new Text('详情页'),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
                // ignore: not_enough_required_arguments
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new WifiDetailPage(new Wifi(null, null, null, null, null, null, null, null, null, 0))));
//                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SidebarPage('First Page')));
              }
          ),
          new ListTile(   //第二个功能项
              title: new Text('我的收藏'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new FavListPage()));
              }
          ),
          new Divider(),    //分割线控件
          new ListTile(   //退出按钮
            title: new Text('关于作者'),
            trailing: new Icon(Icons.arrow_right),
            onTap: () {
              Navigator.of(context).pop();   //点击后收起侧边栏
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new AboutPage(id: "https://yushiwo.github.io/")));
            }

          ),
        ],
      ),
    );
  }

}
