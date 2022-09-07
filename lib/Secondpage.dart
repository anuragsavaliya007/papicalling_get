import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  bool status = false;
  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadalldata();
  }

  loadalldata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
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
      appBar: AppBar(title: Text("SecondApi_get")),
      body: status
          ? (l.length > 0
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {

                    Map map = l[index];

                    User1 user1 = User1.fromJson(map);
                    return ListTile(
                      
                      title: Text("${user1.name}"),
                      subtitle: Text("${user1.email}"),
                      leading: Text("${user1.postId}"),
                      trailing: Text("${user1.id}"),

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

class User1 {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  User1({this.postId, this.id, this.name, this.email, this.body});

  User1.fromJson(Map json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}
