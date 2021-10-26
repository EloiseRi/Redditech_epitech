import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:my_redditech/states/subreddits_state.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/states/subreddits_state.dart';

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
  const PageProfil({Key? key, required this.name, required this.color})
      : super(key: key);
  final String name;
  final Color color;
  @override
  Widget build(BuildContext context) {
  Future<Redditor> Function() redditor = () => Provider.of<GlobalState>(context, listen: false).getUserInfo();
    const urlImage =
        'https://media-exp1.licdn.com/dms/image/C5603AQFrdq9exFkovQ/profile-displayphoto-shrink_800_800/0/1631048636825?e=1640822400&v=beta&t=6okkS6MWfH8prWG8C5wB5uboQ31FtP78K1T3O9Irngk';

    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(250.0), // here the desired height
          child: AppBar(
              flexibleSpace: FlexibleSpaceBarSettings(
                  toolbarOpacity: 1,
                  minExtent: 20,
                  maxExtent: 40,
                  currentExtent: 200,
                  child: CircleAvatar(
                      radius: 30, backgroundImage: NetworkImage(redditor.))),
              foregroundColor: Colors.black,
              centerTitle: true,
              backgroundColor: color),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 50, left: 15),
          // child: Column(children: const <Widget>[
          //   CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage))
          // ]),
        ));
  }
}
