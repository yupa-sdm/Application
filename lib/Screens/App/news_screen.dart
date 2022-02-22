import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/App/drawer_menu.dart';
import 'package:http/http.dart' as Http;
import 'package:flutter_auth/Screens/Login/components/background.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var jsonData;
  List<ListoftemplesData> dataList = [];

  Future<String> _GatData() async {
    var respones = await Http.get(
        'https://numvarn.github.io/resume/asset/files/templeprofile.json');
    jsonData = json.decode(utf8.decode(respones.bodyBytes));

    for (var data in jsonData) {
      ListoftemplesData news = ListoftemplesData(
          data['อันดับ'],
          data['พระเกจิ'],
          data['รายละเอียด'],
          data['ละติจูด'],
          data['ลองติจูด']);
      dataList.add(news);
    }
    return 'ok';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Temples"),
      ),
      drawer: DrawerMenu(),
      body: Background(
        child: FutureBuilder(
          future: _GatData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Align(
                            child: Text(
                              '${dataList[index].monk}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Align(
                            child: Text(
                              '${dataList[index].detail}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Align(
                            child: Text(
                              '${dataList[index].latitude}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Align(
                            child: Text(
                              '${dataList[index].longtitude}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ListoftemplesData {
  String name;
  String monk;
  String detail;
  double latitude;
  double longtitude;
  ListoftemplesData(
      this.name, this.monk, this.detail, this.latitude, this.longtitude);
}
