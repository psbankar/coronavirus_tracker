import 'dart:convert';

import 'package:coronavirus_tracker/model/News.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<News> newsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: newsList.isEmpty? CircularProgressIndicator() : ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (buildcontext, index) {
              return Card(
                child: ExpansionTile(onExpansionChanged: (val){

                },
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        OutlineButton(child: Text('Visit Reddit Post'),onPressed: (){
                            launch('https://www.reddit.com'+newsList.elementAt(index).permalink);
                        }),
                        OutlineButton(child: Text('Visit Page'),onPressed: (){
                          launch(newsList.elementAt(index).url);
                        }),
                      ],
                    )
                  ],
                  title: Text(
                    newsList.elementAt(index).title,
                    style: TextStyle(fontSize: 14.0),
                  ),
                  leading: Container(
                    width: 48.0,
                    height: 48.0,
                    child: newsList.elementAt(index).thumbnail!= 'self' ?Image.network(newsList.elementAt(index).thumbnail) : Container(),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void fetchNews() async {
    http.Response httpresponse =
        await http.get('https://www.reddit.com/r/Coronavirus/.json');
    var jsonresponse = jsonDecode(httpresponse.body);
//    var listOfPosts = jsonDecode(jsonresponse['data']['children'].toString());
    var tempList = jsonresponse['data']['children'];

    for (int i = 0; i < tempList.length; i++) {
      var data = tempList[i]['data'];
      newsList.add(News(
          title: data['title'],
          thumbnail: data['thumbnail'],
          url: data['url'],
          permalink: data['permalink']));
    }
    setState(() {
    });
  }
}
