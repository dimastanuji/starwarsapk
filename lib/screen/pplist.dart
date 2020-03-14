import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:starwarsapk/model/film_model.dart';
import 'package:starwarsapk/model/local.dart';
import 'package:starwarsapk/screen/local_list.dart';
import 'package:starwarsapk/screen/local_save.dart';
class Pplist extends StatefulWidget {
  @override
  _PplistState createState() => _PplistState();
}

class _PplistState extends State<Pplist> {
  @override
  void initState() {
    super.initState();
  }
  Future<List<Result>> getDataFilm() async {
    List<Result> list;
    String link = "https://swapi.co/api/people/";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    // print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["results"] as List;
      print(rest);
      list = rest.map<Result>((json) => Result.fromJson(json)).toList();
    }
    print("List Size: ${list.length}");
    return list;
  }

  Widget listViewWidget(List<Result> results) {
    return Container(
      child: ListView.builder(
            itemCount: results.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, position) {
              return Card(
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  child: Center(
                    child: ListTile(
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          '${results[position].name}',
                        ),
                      ),
                      title: Text(
                        '${results[position].height}',
                        style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {debugPrint('FAB clicked');
		                  navigateToDetail(context,Local('', '', '', 3), "People", results[position]);}
                    ),
                  ),
                ),
              );
            }),
    );
  }

  void navigateToDetail(BuildContext context,Local local, String title, Result rresult) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return LocalSave(local,rresult,title);
	  }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Home"),
        elevation: 0.0,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: InkResponse(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocalList()));
                  },
                  child: Icon(Icons.save),
                ),
              ),
              
            ],
          )
        ],
      ),
      body:  FutureBuilder(
                future: getDataFilm(),
                builder: (ontext, snapshot) {
                  return snapshot.data != null
                      ? listViewWidget(snapshot.data)
                      : Center(child: CircularProgressIndicator());
                }),
      
    
    );
  }
}