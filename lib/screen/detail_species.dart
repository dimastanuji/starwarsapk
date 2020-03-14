import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum(String url) async {
  final response =
      await http.get('$url');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String name;
  final  String classification;
   final String designation;
  final  String averageHeight;
  final  String skinColors;
  final  String hairColors;
   final String eyeColors;
  final  String averageLifespan;
   final String homeworld;
  final  String language;
  final  List<String> people;
  final  List<String> films;
   final DateTime created;
   final DateTime edited;
   final String url;

  Album({
        this.name,
        this.classification,
        this.designation,
        this.averageHeight,
        this.skinColors,
        this.hairColors,
        this.eyeColors,
        this.averageLifespan,
        this.homeworld,
        this.language,
        this.people,
        this.films,
        this.created,
        this.edited,
        this.url,
    });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json["name"],
        classification: json["classification"],
        designation: json["designation"],
        averageHeight: json["average_height"],
        skinColors: json["skin_colors"],
        hairColors: json["hair_colors"],
        eyeColors: json["eye_colors"],
        averageLifespan: json["average_lifespan"],
        homeworld: json["homeworld"],
        language: json["language"],
        people: List<String>.from(json["people"].map((x) => x)),
        films: List<String>.from(json["films"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
    );
  }

  num get length => null;

}


class Species extends StatefulWidget {
  final String url;
  Species(this.url);

  @override
  _MyAppState createState() => _MyAppState(url);
}

class _MyAppState extends State<Species> {
  final String url;
  _MyAppState (this.url);
Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(url);
  }

  @override
  Widget build(BuildContext context) {
    int data;
    return MaterialApp(
      title: 'Detail People',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detail People'),
        ),
        body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[
            Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Parsonal Information',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.name);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
                                                        ],
                          )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Classification',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                             FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              for(data=0;data<4;data++){
                if (snapshot.hasData) {
                return Text(snapshot.data.classification);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),  
                                                        ],
                          )),
                          Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    'Language',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                             FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              for(data=0;data<4;data++){
                if (snapshot.hasData) {
                return Text(snapshot.data.language);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),  
                                                ],
                          )),
          ]
          )
        )  
        ),
    );
  }
}
