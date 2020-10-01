import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> data;
  List covidData;

  Future getData() async {
    http.Response response =
        await http.get("https://dekontaminasi.com/api/id/covid19/stats");
    data = json.decode(response.body);
    setState(() {
      covidData = data["regions"];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Covid Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: covidData == null ? 0 : covidData.length,
        itemBuilder: (BuildContext context, int index) {
          return Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${covidData[index]["name"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${covidData[index]["numbers"]["infected"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber),
                              ),
                              Text(
                                "${covidData[index]["numbers"]["recovered"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                "${covidData[index]["numbers"]["fatal"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
