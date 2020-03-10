import 'dart:convert';

import 'package:coronavirus_tracker/model/country_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryWiseData extends StatefulWidget {
  @override
  _CountryWiseDataState createState() => _CountryWiseDataState();
}

class _CountryWiseDataState extends State<CountryWiseData> {
  List<CountryData> countryDataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: countryDataList.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: countryDataList.length,
                itemBuilder: (buildcontext, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Card(
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(countryDataList.elementAt(index).country,
                                style: TextStyle(
                                    fontSize: 22.0, fontWeight: FontWeight.bold)),
                            GridView.count(childAspectRatio: 5, shrinkWrap: true,primary: false,crossAxisCount: 2,children: <Widget>[
                              IndividualData(title: 'Cases',value:  countryDataList.elementAt(index).cases.toString(),),
                              IndividualData(title: 'Cases Today',value:  countryDataList.elementAt(index).todayCases.toString(),),
                              IndividualData(title: 'Deaths',value:  countryDataList.elementAt(index).deaths.toString(),),
                              IndividualData(title: 'Deaths Today',value:  countryDataList.elementAt(index).todayDeaths.toString(),),
                              IndividualData(title: 'Recovered',value:  countryDataList.elementAt(index).recovered.toString(),),
                              IndividualData(title: 'Critical',value:  countryDataList.elementAt(index).critical.toString(),),
                            ],)

                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }

  void fetchData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/countries');
    List jsonresponse = jsonDecode(response.body);

    for (int i = 0; i < jsonresponse.length; i++) {
      var temp = jsonresponse[i];
      countryDataList.add(CountryData(
        country: temp['country'],
        cases: temp['cases'],
        todayCases: temp['todayCases'],
        critical: temp['critical'],
        deaths: temp['deaths'],
        recovered: temp['recovered'],
        todayDeaths: temp['todayDeaths'],
      ));
    }
    countryDataList.sort((a,b) => a.country.compareTo(b.country));
    setState(() {});
  }
}

class IndividualData extends StatefulWidget {

  String title;
  String value;

  IndividualData({this.title, this.value});

  @override
  _IndividualDataState createState() => _IndividualDataState();
}

class _IndividualDataState extends State<IndividualData> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(widget.title+' : '),
          Text(widget.value),
        ],
      ),
    );
  }
}
