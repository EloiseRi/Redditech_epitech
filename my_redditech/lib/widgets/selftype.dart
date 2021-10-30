import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:url_launcher/url_launcher.dart';

class SelfType extends StatelessWidget {
  final String content;

  const SelfType({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content.isNotEmpty
        ? Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.all(4),
            decoration:
                const BoxDecoration(color: Color.fromARGB(20, 20, 20, 20)),
            child: MarkdownBody(
              data: HtmlUnescape().convert(content),
            ),
          )
        : Container();
  }
}
