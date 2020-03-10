import 'package:coronavirus_tracker/screens/country_wise_data.dart';
import 'package:coronavirus_tracker/screens/news_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String cases;
  String deaths;
  String recovered;


  @override
  void initState() {
    super.initState();
    fetchAllCasesData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: cases == null ? CircularProgressIndicator() : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text('Coronavirus Statistics', style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  ),
                  HeadingWithData(
                    heading: 'Cases',
                    data: cases.toString(),
                    color: Colors.amberAccent[100],
                  ),
                  HeadingWithData(
                    heading: 'Deaths',
                    data: deaths,
                    color: Colors.redAccent[100],
                  ),
                  HeadingWithData(
                    heading: 'Recovered',
                    data: recovered,
                    color: Colors.greenAccent[100],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Country Wise Data', style: TextStyle(fontSize: 22.0),),
                        ), onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (b)=> CountryWiseData()));
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('News about CoronaVirus', style: TextStyle(fontSize: 22.0),),
                        ), onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (b)=> NewsPage()));

                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchAllCasesData() async{
    http.Response response = await http.get('https://corona.lmao.ninja/all');
    var jsonresponse = jsonDecode(response.body);
    setState(() {
      cases = jsonresponse['cases'].toString();
      deaths = jsonresponse['deaths'].toString();
      recovered = jsonresponse['recovered'].toString();
    });

  }
}

class HeadingWithData extends StatefulWidget {
  String heading;
  String data;

  var color;

  HeadingWithData(
      {@required this.heading, @required this.data, @required this.color});

  @override
  _HeadingWithDataState createState() => _HeadingWithDataState();
}

class _HeadingWithDataState extends State<HeadingWithData> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          widget.heading,
          style: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: widget.color),
        ),
        Text(
          widget.data,
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.w400, color: widget.color),
        ),
      ],
    ));
  }
}
