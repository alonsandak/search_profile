import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'post_model.dart';

Future<List<Post>> fetchPost() async {
  final response =
  await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Post>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
        title: 'Search Profile Data ',
        theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
    ),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
    appBar: AppBar(
    title: Text('Search Profile Analyzie '),
    ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Widgets
              Container(
                width: double.infinity,
                // color: Colors.green,
                //height: _size.height * 0.25, // Take 25% width of the screen height
                height  :    90.00 ,
                child:
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(hintText: 'Profile we Search '),
                          onTap: (){print('API CALL HERE');},
                        ),

                      )
                    ],
                  )

              ),

              Expanded(
                child:   Container(
                  child: bulidlist(futurePost: futurePost),
                ),
              ),

              // Bottom Widgets
              Container(
                width: double.infinity,
                // color: Colors.blue,
                height: 50.00, // Take 25% width of the screen height
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Profile sentiment is : ', style: TextStyle(fontSize: 23.0),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
    );
  }
}

class bulidlist extends StatelessWidget {
  const bulidlist({
    Key key,
    @required this.futurePost,
  }) : super(key: key);

  final Future<List<Post>> futurePost;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: futurePost,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
            Scrollbar(
              child:
              ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) => Container(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Color(0xff97FFFF),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data[index].title}",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("${snapshot.data[index].body}"),
                    ],
                  ),
                ),
              ),
          ),
            );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
