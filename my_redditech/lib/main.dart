import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_redditech/states/global_state.dart';
import 'package:my_redditech/states/subreddits_state.dart';
import 'package:my_redditech/utils/palette.dart';
import 'package:provider/provider.dart';
import 'package:my_redditech/screens/login_page.dart';
import 'package:my_redditech/screens/home_page.dart';

Future<void> main() async {
  GlobalState globalState = GlobalState();
  SubredditsState subredditsState = SubredditsState();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.white,
    systemStatusBarContrastEnforced: false,
  ));

  await globalState.initApp();
  runApp(MyApp(
    globalState: globalState,
    subredditsState: subredditsState,
  ));
}

class MyApp extends StatelessWidget {
  final GlobalState globalState;
  final SubredditsState subredditsState;

  const MyApp({
    Key? key,
    required this.globalState,
    required this.subredditsState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalState>.value(
          value: globalState,
        ),
        ChangeNotifierProvider<SubredditsState>.value(
          value: subredditsState,
        )
      ],
      child: MaterialApp(
        title: 'Redditech',
        debugShowCheckedModeBanner:  false,
        theme: ThemeData(
          primarySwatch: Palette.orangeReddit,
          scaffoldBackgroundColor: Colors.grey.shade200,
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
