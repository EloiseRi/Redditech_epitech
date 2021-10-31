import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/posts_page.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:my_redditech/states/posts_state.dart';
import 'package:my_redditech/utils/name_tabs.dart';
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

class PageProfil extends StatefulWidget {
  const PageProfil({Key? key, required this.name, required this.color})
      : super(key: key);
  final String name;
  final Color color;

  @override
  State<PageProfil> createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  late Redditor redditor;
  late Stream<UserContent> subContent;

  @override
  Widget build(BuildContext context) {
    redditor = Provider.of<GlobalState>(context, listen: false).redditor;
    final subcribers = redditor.data!['subreddit']['subscribers'] != null
        ? redditor.data!['subreddit']['subscribers'].toString()
        : '0';
    final description =
        (redditor.data!['subreddit']['public_description']) == null
            ? ''
            : redditor.data!['subreddit']['public_description'];
    final media = MediaQuery.of(context).size;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
          length: tabsSubProfil.length,
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {});
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(295.0),
                  child: AppBar(
                    toolbarHeight: 400,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.only(top: 40, left: 0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            child: Image.network(
                              redditor.data!['snoovatar_img'].toString(),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            'u/' + redditor.displayName.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: media.aspectRatio * 150, top: 10)),
                              Text(
                                  redditor.data!['total_karma'].toString() +
                                      ' karma · ' +
                                      (DateTime.now()
                                              .difference(redditor.createdUtc!))
                                          .inDays
                                          .toString() +
                                      " d · " +
                                      (DateTime.now().day.toString()) +
                                      " " +
                                      (DateTime.now().month.toString()) +
                                      " " +
                                      (DateTime.now().year.toString()) +
                                      " · " +
                                      subcribers +
                                      " subscriber(s)",
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            description.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    foregroundColor: Colors.black,
                    centerTitle: true,
                    backgroundColor: widget.color,
                    bottom: const TabBar(
                      tabs: tabsSubProfil,
                      labelColor: Colors.black,
                    ),
                  )),
              body: TabBarView(
                children: [
                  Column(
                    children: const [
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Text('Ohh No, It\'s empty'),
                    ],
                  ),
                  Column(
                    children: const [
                      Padding(padding: EdgeInsets.only(top: 50)),
                      Text('Ohh No, It\'s empty'),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Row(children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: media.aspectRatio * 60)),
                          Text(
                              'Karma publication: ' +
                                  redditor.data!['link_karma'].toString(),
                              style: const TextStyle(fontSize: 12)),
                          const Padding(padding: EdgeInsets.only(left: 15)),
                          Text(
                            'Karma comments: ' +
                                redditor.data!['comment_karma'].toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ]),
                        const Padding(padding: EdgeInsets.all(10)),
                        Row(children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: media.aspectRatio * 60)),
                          Text(
                              'Karma de philanthrope: ' +
                                  redditor.data!['awarder_karma'].toString(),
                              style: const TextStyle(fontSize: 12)),
                          const Padding(padding: EdgeInsets.only(left: 15)),
                          Text(
                              'Karma de récipiendaire: ' +
                                  redditor.data!['awardee_karma'].toString(),
                              style: const TextStyle(fontSize: 12)),
                        ]),
                        const Padding(padding: EdgeInsets.all(10)),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}
