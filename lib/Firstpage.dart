import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Firstpage extends StatefulWidget {
  const Firstpage({Key? key}) : super(key: key);

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAlldata();
  }

  loadAlldata() async {
    // http,dio
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
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
      appBar: AppBar(title: Text("Api_get")),
      body: status
          ? (l.length > 0
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Map map = l[index];

                    Users users = Users.fromJson(map);

                    return ListTile(
                      leading: Text("${users.id}"),
                      title: Text("${users.title}"),
                      subtitle: Text("${users.body}"),
                    );
                  },
                )
              : Center(
                  child: Text("No data Found"),
                ))
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class Users {
  int? userId;
  int? id;
  String? title;
  String? body;

  Users({this.userId, this.id, this.title, this.body});

  Users.fromJson(Map json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
