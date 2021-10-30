import 'package:draw/draw.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkType extends StatefulWidget {
  final Submission post;
  const LinkType({Key? key, required this.post}) : super(key: key);

  @override
  _LinkTypeState createState() => _LinkTypeState();
}

class _LinkTypeState extends State<LinkType> {
  Submission get _post => widget.post;

  Future<dynamic> _fetchData() async {
    try {
      var response = await http.get(_post.url);
      var document = responseToDocument(response);
      var data = MetadataParser.parse(document);
    } catch (e) {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
