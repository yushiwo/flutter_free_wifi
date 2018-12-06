import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: _buildDrawer(),  // 侧边栏
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
            otherAccountsPictures: <Widget>[    //粉丝头像
              new GestureDetector(    //手势探测器，可以识别各种手势，这里只用到了onTap
                onTap: () => print('other user'), //暂且先打印一下信息吧，以后再添加跳转页面的逻辑
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/10878817/240ab127-e41b-496b-80d6-fc6c0c99f291?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                ),
              ),
              new GestureDetector(
                onTap: () => print('other user'),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                ),
              ),
            ],
            decoration: new BoxDecoration(    //用一个BoxDecoration装饰器提供背景图片
              image: new DecorationImage(
                fit: BoxFit.fill,
                // image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
                //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
                image: new ExactAssetImage('images/lake.jpg'),
              ),
            ),
          ),
          new ListTile(   //第一个功能项
              title: new Text('First Page'),
              trailing: new Icon(Icons.arrow_upward),
              onTap: () {
                Navigator.of(context).pop();
//                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SidebarPage('First Page')));
              }
          ),
          new ListTile(   //第二个功能项
              title: new Text('Second Page'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
//                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SidebarPage('Second Page')));
              }
          ),
          new ListTile(   //第二个功能项
              title: new Text('Second Page'),
              trailing: new Icon(Icons.arrow_right),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/a');
              }
          ),
          new Divider(),    //分割线控件
          new ListTile(   //退出按钮
            title: new Text('Close'),
            trailing: new Icon(Icons.cancel),
            onTap: () => Navigator.of(context).pop(),   //点击后收起侧边栏
          ),
        ],
      ),
    );
  }

}
