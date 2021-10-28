import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/controller_page.dart';
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
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: DefaultTabController(
          length: tabs.length,
          child: Builder(builder: (BuildContext context) {
            final TabController tabController =
                DefaultTabController.of(context)!;
            tabController.addListener(() {});
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(270.0),
                  child: AppBar(
                    toolbarHeight: 400,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.only(top: 35, left: 0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            child: Image.network(
                              redditor.data!['snoovatar_img'].toString(),
                            ),
                            backgroundColor: Colors.grey.shade200,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            'u/' + redditor.displayName.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(padding: EdgeInsets.only(left: 90)),
                              Text(
                                  redditor.data!['total_karma'].toString() +
                                      ' karma · ' +
                                      (DateTime.now()
                                              .difference(redditor.createdUtc!))
                                          .inDays
                                          .toString() +
                                      " j · " +
                                      (DateTime.now().day.toString()) +
                                      " " +
                                      (DateTime.now().month.toString()) +
                                      " " +
                                      (DateTime.now().year.toString()) +
                                      " · " +
                                      subcribers +
                                      " abonné(e)",
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Text(
                            description.toString(),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    foregroundColor: Colors.black,
                    centerTitle: true,
                    backgroundColor: widget.color,
                    bottom: const TabBar(
                      tabs: tabs,
                      labelColor: Colors.black,
                    ),
                  )),
              body: TabBarView(
                children: [
                  Column(
                    children: [
                      Row(children: [
                        const Icon(Icons.ac_unit),
                        const Icon(Icons.ac_unit),
                        Text(
                            'Karma ' + redditor.data!['total_karma'].toString())
                      ]),
                    ],
                  ),
                  Column(
                    children: const [Text('Wouah, c\'est vide')],
                  ),
                  Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 90)),
                      Row(children: [
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        const Text('Karma de publications: '),
                        Text(redditor.data!['link_karma'].toString()),
                        const Padding(
                            padding: EdgeInsets.only(top: 90, left: 20)),
                        Text('Karma de commentaires: ' +
                            redditor.data!['comment_karma'].toString()),
                      ]),
                      Row(children: [
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        Text('Karma de philanthrope: ' +
                            redditor.data!['awarder_karma'].toString()),
                        const Padding(
                            padding: EdgeInsets.only(top: 40, left: 20)),
                        Text('Karma de récipiendaire: ' +
                            redditor.data!['awardee_karma'].toString()),
                      ]),
                      const Divider(
                        color: Colors.black,
                      )
                    ],
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
