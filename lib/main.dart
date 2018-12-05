import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '附近免费的Wi-Fi',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<String> _suggestions = <String>[];
  final Set<String> _saved = new Set<String>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
        child: new Text("\n\n\nDrawer Is Here"),
      ),
      appBar: new AppBar(
        title: const Text('附近免费的Wi-Fi'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  // 获取附近的wifi（测试截断）
  void _requestNearByWifi() async {
    var dio = new Dio(Options(
        baseUrl: "https://www.baidu.com"
    ));
    Response response = await dio.get("http://apis.juhe.cn/wifi/local?key=85e9b14aa37e5929e14d961f73a40367&lon=116.366324&lat=39.905859&r=3000&type=1");
    print(response.data["result"]["data"].length);
    int length = response.data["result"]["data"].length;
    for(int i = 0; i < length; i++ ) {
      _suggestions.add(response.data["result"]["data"][i]["name"]);
    }

    setState(() {

    });
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return const Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            for(int j = 0; j < 10; j++) {
              _suggestions.add(j.toString());
            }
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(String pair) {
    if (pair == null) {
      return null;
    }
    final bool alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.toUpperCase(),
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(() {

          if(alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });

        _requestNearByWifi();
      },
    );
  }

  // 进入我的收藏页面
  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (String pair) {
              return new ListTile(
                title: new Text(
                  pair.toUpperCase(),
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();

          return new Scaffold(         // 新增 6 行代码开始 ...
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );                           // ... 新增代码段结束.
        },
      ),
    );
  }
}
