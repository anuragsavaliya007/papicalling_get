import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Thirdpage extends StatefulWidget {
  const Thirdpage({Key? key}) : super(key: key);

  @override
  State<Thirdpage> createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
  List l = [];
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadalldata();
  }

  loadalldata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
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
      appBar: AppBar(title: Text("ThirdApi_get")),
      body: status
          ? (l.length > 0
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {

                    Map map = l[index];
                    User2 user2 = User2.fromJson(map);
                    return ListTile(
                      leading: Text("${user2.id}"),
                      title: Text("${user2.title}"),
                      subtitle: Text("${user2.userId}"),
                    );
                  },
                )
              : Center(
                  child: Text("No Data Found"),
                ))
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class User2 {
  int? userId;
  int? id;
  String? title;

  User2({this.userId, this.id, this.title});

  User2.fromJson(Map json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}