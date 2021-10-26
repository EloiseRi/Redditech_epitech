import 'package:flutter/material.dart';
import 'package:my_redditech/screens/sub_page_profil/sub_profil.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const urlImage =
        'https://media-exp1.licdn.com/dms/image/C5603AQFrdq9exFkovQ/profile-displayphoto-shrink_800_800/0/1631048636825?e=1640822400&v=beta&t=6okkS6MWfH8prWG8C5wB5uboQ31FtP78K1T3O9Irngk';
    return Drawer(
      child: Container(
        color: Colors.white12,
        child: ListView(
          children: <Widget>[
            const CircleAvatar(
                radius: 30, backgroundImage: NetworkImage(urlImage)),
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
              height: 50,
            ),
            buildMenuItem(
                text: 'Paramètres',
                icon: Icons.settings,
                onClicked: () => selectedItem(context, 4)),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
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
          builder: (context) => const SubProfil(
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
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PageParameters(
            name: 'Paramètres',
            color: Colors.white,
          ),
        ));
        break;
    }
  }
}
