import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor orangeReddit = MaterialColor(
    0xfff34501,
    <int, Color>{
      50: Color(0xff000000),
      100: Color(0xff310e00),
      200: Color(0xff491500),
      300: Color(0xff611c00),
      400: Color(0xff7a2301),
      500: Color(0xff922901),
      600: Color(0xffaa3001),
      700: Color(0xffc23701),
      800: Color(0xffdb3e01),
      900: Color(0xfff34501),
    },
  );
}

class Button extends StatefulWidget {
  const Button({Key? key, required this.name, required Function()? onPressed})
      : super(key: key);
  final String name;
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(widget.name),
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontSize: 23),
        minimumSize: const Size(110, 45),
        primary: Colors.white,
        backgroundColor: const Color.fromARGB(255, 243, 69, 1),
      ),
    );
  }
}
