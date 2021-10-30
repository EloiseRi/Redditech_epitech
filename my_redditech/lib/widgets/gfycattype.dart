import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/widgets/imagetype.dart';

class GfycatVideoType extends StatefulWidget {
  final Uri url;

  const GfycatVideoType({Key? key, required this.url}) : super(key: key);

  @override
  _GfycatVideoTypeState createState() => _GfycatVideoTypeState();
}

class _GfycatVideoTypeState extends State<GfycatVideoType> {
  Future<String> _retrieveLink() async {
    String videoName = widget.url.path.substring(1);

    Response response =
        await Dio().get('https://api.gfycat.com/v1/gfycats/$videoName');

    Map<String, dynamic> json = jsonDecode(response.toString());

    return json["gfyItem"]["gifUrl"];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _retrieveLink(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ImageType(
            url: snapshot.data.toString(),
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: EdgeInsets.all(4),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(children: <Widget>[
              Icon(
                Icons.error,
                color: Colors.orangeAccent.shade200,
              ),
              Text(
                "Couldn't retrieve content",
                style: TextStyle(
                  color: Colors.grey.shade100,
                ),
              ),
            ]),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.orangeAccent.shade200,
              ),
              backgroundColor: Colors.grey.shade700,
            ),
          );
        }
      },
    );
  }
}
