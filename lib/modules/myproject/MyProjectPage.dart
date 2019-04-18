import 'package:flutter/material.dart';

class MyProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("我的作品"),
      ),
      
      body: new Padding(
        padding: new EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            // 第一排
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: new Row(
                children: <Widget>[
                  // 财报说
                  getProjectView("images/ic_logo_cbs.png", "财报说"),

                  // OTC场外
                  getProjectView("images/ic_logo_otc.png", "场外交易")
                ],
              ),
            ),


            // 第二排
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: new Row(
                children: <Widget>[
                  // exchange
                  getProjectView("images/ic_logo_exchange.png", "币币交易"),

                  // kada
                  getProjectView("images/ic_logo_kada.png", "网易咔搭编程")
                ],
              ),
            ),

            // 第三排
            new Padding(
              padding: new EdgeInsets.all(0.0),
              child: new Row(
                children: <Widget>[
                  // 网易100分
                  getProjectView("images/ic_logo_100.png", "网易100分"),
                  getProjectView("images/ic_logo_qlive.png", "网易青果")
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget getProjectView(String imagePath, String projectName) {
    return new Expanded(
      flex: 1,
      child: new Card(
        child: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            children: <Widget>[

              new Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
              ),

              new Padding(
                padding: new EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                child: new Text(
                  projectName,
                  style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              )

            ],
          ),
        )
      ),
    );
  }

}