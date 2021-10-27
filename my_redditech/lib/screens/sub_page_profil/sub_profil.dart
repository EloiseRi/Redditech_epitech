import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:provider/provider.dart';

class SubProfil extends StatelessWidget {
  const SubProfil({Key? key, required this.name, required this.color})
      : super(key: key);

  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.black,
            title: Text(name),
            centerTitle: true,
            backgroundColor: color),
      );
}

class PageProfil extends StatelessWidget {
  PageProfil({Key? key, required this.name, required this.color})
      : super(key: key);
  final String name;
  final Color color;
  late Redditor redditor;

  // TODO - widget avec la fonction :
  // penser à envoyer le context à la classe enfant
  // Chercher un logo fixe "par défaut" à retourner si rien dans data
  String getUserPict(BuildContext context) {
    String? urlPict = '';
    urlPict = Provider.of<GlobalState>(context, listen: true)
            .redditor
            .data!['subreddit']['snoovatar_img'] ??
        Provider.of<GlobalState>(context, listen: true)
            .redditor
            .data!['subreddit']['icon_img'];
    return urlPict ?? '';
  }

  @override
  Widget build(BuildContext context) {
    redditor = Provider.of<GlobalState>(context, listen: false).redditor;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(250.0), // here the desired height
          child: AppBar(
              flexibleSpace: FlexibleSpaceBarSettings(
                  toolbarOpacity: 1,
                  minExtent: 200,
                  maxExtent: 400,
                  currentExtent: 200,
                  child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(getUserPict(context)))),
              foregroundColor: Colors.black,
              centerTitle: true,
              backgroundColor: color),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 50, left: 15),
          // child: Column(children: const <Widget>[Provider.of<GlobalState>(context, listen: false).redditor
          //   CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage))
          // ]),
        ));
  }
}
