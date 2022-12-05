import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripmap/screens/homescreen.dart';
import 'package:tripmap/screens/homescreen2.dart';
import 'package:tripmap/screens/loginscreen.dart';
import 'package:tripmap/screens/contentscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

Future<bool> _onWillPop() async {
  return false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: ContentScreen(),
      ),
    );
  }
}
