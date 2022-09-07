import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fourthpage extends StatefulWidget {
  const Fourthpage({Key? key}) : super(key: key);

  @override
  State<Fourthpage> createState() => _FourthpageState();
}

class _FourthpageState extends State<Fourthpage> {
  bool status = false;
  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadalldata();
  }

  loadalldata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      l = jsonDecode(response.body);
      print(l);
    }

    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FourApi_get")),
      body: status
          ? (l.length > 0
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {

                    Map map = l[index];

                   welcome wlc = welcome.fromJson(map);

                    return ListTile(
                      title: Text("${wlc.title}"),
                      subtitle: Text("${wlc.thumbnailUrl}"),
                      leading: Text("${wlc.id}"),
                    );
                  },
                )
              : Center(
                  child: Text("No Dtata Found"),
                ))
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class welcome {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  welcome({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  welcome.fromJson(Map json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['albumId'] = this.albumId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
