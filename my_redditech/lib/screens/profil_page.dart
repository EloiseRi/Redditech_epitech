import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:my_redditech/screens/sub_page_profil/sub_profil.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);
  late Redditor redditor;
  @override
  Widget build(BuildContext context) {
    redditor = Provider.of<GlobalState>(context, listen: false).redditor;

    final urlImage = redditor.data!['snoovatar_img'].toString();
    return Drawer(
      child: Container(
        color: Colors.white12,
        child: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 10)),
            urlImage != ''
                ? Image.network(
                    redditor.data!['snoovatar_img'].toString(),
                    height: 200,
                  )
                : Image.network(
                    redditor.data!['icon_img'].toString(),
                    height: 200,
                  ),
            Text(
              "u/" + redditor.displayName.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black, fontSize: 20, fontFamily: 'OpenSans'),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(children: [
              const Padding(padding: EdgeInsets.only(left: 32)),
              const Icon(Icons.filter_vintage_outlined),
              const Padding(padding: EdgeInsets.only(right: 8)),
              Column(
                children: [
                  (redditor.data!['total_karma'] > 999)
                      ? Text(NumberFormat.compactCurrency(
                              decimalDigits: 1, symbol: '')
                          .format(redditor.data!['total_karma'])
                          .toString())
                      : Text((redditor.data!['total_karma']).toString()),
                  const Text(
                    'Karma',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 60, top: 20)),
              const Icon(Icons.cake_outlined),
              const Padding(padding: EdgeInsets.only(left: 10, top: 20)),
              Column(
                children: [
                  Text((DateTime.now().difference(redditor.createdUtc!))
                          .inDays
                          .toString() +
                      " j"),
                  const Text('Âge Reddit'),
                ],
              ),
            ]),
            const Divider(
              color: Colors.black,
            ),
            buildMenuItem(
                text: 'Mon profil',
                icon: Icons.face_retouching_natural_sharp,
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                text: 'Créer une communauté',
                icon: Icons.people,
                onClicked: () => selectedItem(context, 1)),
            buildMenuItem(
                text: 'Pièces Reddit',
                icon: Icons.monetization_on_outlined,
                onClicked: () => selectedItem(context, 2)),
            buildMenuItem(
                text: 'Sauvegardé',
                icon: Icons.bookmark_rounded,
                onClicked: () => selectedItem(context, 3)),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () async {
                await Provider.of<GlobalState>(context, listen: false).logout();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: buildMenuItem(text: 'Log out', icon: Icons.settings),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.grey.shade900;
    final hoverColor = Colors.green;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int i) {
    Navigator.of(context).pop();
    switch (i) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PageProfil(
            name: 'Profil',
            color: Colors.white,
          ),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SubProfil(
            name: 'Créer une communauté',
            color: Colors.white,
          ),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SubProfil(
            name: 'Pièces Reddit',
            color: Colors.white,
          ),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SubProfil(
            name: 'Sauvergardé',
            color: Colors.white,
          ),
        ));
        break;
    }
  }
}
