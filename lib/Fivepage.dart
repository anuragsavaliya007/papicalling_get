import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fivepage extends StatefulWidget {
  const Fivepage({Key? key}) : super(key: key);

  @override
  State<Fivepage> createState() => _FivepageState();
}

class _FivepageState extends State<Fivepage> {
  bool status = false;

  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadalldata();
  }

  loadalldata() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
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
      appBar: AppBar(title: Text("FiveApi_get")),
      body: status
          ? (l.length > 0
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {


                    Users5 user5 = Users5.fromJson(l[index]);

                    return ListTile(
                      
                      title: Text("${user5.title}"),
                      subtitle: Text("${user5.userId}"),
                       leading: Text("${user5.id}"),
                      
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

class Users5 {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Users5({this.userId, this.id, this.title, this.completed});

  Users5.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['completed'] = this.completed;
    return data;
  }
}
