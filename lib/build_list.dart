import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchprofile/post_model.dart';

class BuildList extends StatelessWidget {
  const BuildList ({
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
                        Text("${snapshot.data[index].body }"),
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