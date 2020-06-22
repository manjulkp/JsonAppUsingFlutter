import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Model/Data.dart';
import 'DetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<ColorSwatch> color = [Colors.deepOrange,Colors.red,Colors.purple,Colors.black];
  List<Color> colors = [Colors.blue, Colors.amber, Colors.pink];

  Future<List<Data>> getAllData() async {
    // print("the length ");
    var api = "https://jsonplaceholder.typicode.com/photos";
    var data = await http.get(api);
    var jsonData = json.decode(data.body);

    List<Data> listOf = [];

    for (var i in jsonData) {
      Data data = new Data(i["id"], i["title"], i["url"], i["thumbnailUrl"]);
      listOf.add(data);
    }
    print("the length is ${listOf.length}");
    return listOf;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Json Parsing App"),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => debugPrint("Search")),
          new IconButton(
              icon: new Icon(Icons.add), onPressed: () => debugPrint("add")),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Manjula"),
              accountEmail: new Text("pudding@test.moo"),
              decoration: new BoxDecoration(color: Colors.deepOrangeAccent),
            ),
            new ListTile(
              title: new Text("First Flag"),
              leading: new Icon(Icons.search, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Second Flag"),
              leading: new Icon(Icons.add, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Third Flag"),
              leading: new Icon(Icons.title, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Fourth Flag"),
              leading: new Icon(Icons.phone, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            new Divider(
              height: 50.0,
              color: Colors.pink,
            ),
            new ListTile(
              title: new Text("Close"),
              leading: new Icon(Icons.close, color: Colors.orange),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(10.0),
            height: 250,
            child: new FutureBuilder(
              future: getAllData(),
              builder: (BuildContext c, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text("Loading ...."),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext c, int index) {
                        Color mColor = colors[index % colors.length];

                        return Card(
                          elevation: 10.0,
                          child: new Column(
                            children: <Widget>[
                              new Image.network(
                                snapshot.data[index].url,
                                height: 150.0,
                                width: 150.0,
                                fit: BoxFit.cover,
                              ),
                              new SizedBox(
                                height: 7.0,
                              ),
                              new Container(
                                margin: EdgeInsets.all(6.0),
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      child: new CircleAvatar(
                                        backgroundColor: mColor,
                                        foregroundColor: Colors.white,
                                        child: new Text(
                                          snapshot.data[index].id.toString(),
                                        ),
                                      ),
                                    ),
                                    new SizedBox(width: 6.0),
                                    new Container(
                                      width: 200.0,
                                      child: new Text(
                                        snapshot.data[index].title,
                                        maxLines: 1,
                                        style:
                                            TextStyle(color: Colors.deepOrange),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
          new SizedBox(
            height: 7.0,
          ),
          new Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(10.0),
            child: new FutureBuilder(
                future: getAllData(),
                builder: (BuildContext c, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text("Loading ...."),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext c, int index) {
                          Color mColor = colors[index % colors.length];
                          return Card(
                            elevation: 7.0,
                            child: Container(
                              height: 80.0,
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child: new Image.network(
                                      snapshot.data[index].thumbnailUrl,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 6.0,
                                  ),
                                  new Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      child: new Text(
                                        snapshot.data[index].title,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (BuildContext c) =>
                                                    DetailPage(
                                                        snapshot.data[index])));
                                      },
                                    ),
                                  ),
                                  new SizedBox(
                                    width: 6.0,
                                  ),
                                  new Expanded(
                                    flex: 2,
                                    child: new CircleAvatar(
                                      backgroundColor: mColor,
                                      foregroundColor: Colors.white,
                                      child: new Text(
                                        snapshot.data[index].id.toString(),
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

//new Container(
//height: MediaQuery.of(context).size.height,
//margin: EdgeInsets.all(10.0),
//
//child: new FutureBuilder(future: getAllData(),
//builder: (BuildContext c, AsyncSnapshot snapshot) {
//
//if (snapshot.data == null) {
//return Center(
//child: Text("Loading ...."),
//);
//}
//else
//{
//return ListView.builder(
//
//
//itemCount: snapshot.data.length,
//itemBuilder: (BuildContext c, int index) {
//
//return Card(
//elevation: 7.0,
//child: new Row(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//new Expanded(
//flex:1,
//child: new Image.network(
//snapshot.data[index].url,
//height: 100.0,
//fit: BoxFit.cover,
//),
//
//),
//
//new Expanded(
//flex:2,
//child: new Image.network(
//snapshot.data[index].title,
//height: 100.0,
//
//fit: BoxFit.cover,
//),
//
//),
//
//
//
//
//],),
//
//);
//
//
//
//}
//
//
//
//);
//}
//
//
//}
//
//
//),
//
//),
