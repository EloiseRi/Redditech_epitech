import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_redditech/utils/color_chart.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/screens/home_page.dart';
import 'package:my_redditech/screens/user_page.dart';

Future<void> main() async {
  GlobalState globalState = GlobalState();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: rGrey,
    systemStatusBarContrastEnforced: false,
  ));

  await globalState.initApp();
  runApp(MyApp(globalState: globalState));
}

class MyApp extends StatelessWidget {
  final GlobalState globalState;

  const MyApp({Key? key, required this.globalState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalState>.value(
          value: globalState,
        ),
      ],
      child: MaterialApp(
        title: 'Redditech',
        theme: ThemeData(
          primarySwatch: rOrge,
          scaffoldBackgroundColor: rGrey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/home': (context) => const HomePage(name: 'TestUser')
        },
      ),
    );
  }
}