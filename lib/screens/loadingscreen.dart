import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmap/screens/loginscreen.dart';
import 'package:tripmap/services/authservices.dart';
import 'package:tripmap/services/gradienttext.dart';

class LoadingScreen extends StatefulWidget {
  static bool isLogined = false;
  static String currentRoute = '/homepage';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late String userName, password;

  void tryToLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    password = prefs.getString('password') ?? '';
    await AuthService().login(userName.toString(), password.toString()).then(
      (val) async {
        if (val.data['success']) {
          await AuthService().getinfo(val.data['token']).then(
            (val) {
              if (val.data['success']) {
                LoadingScreen.isLogined = true;
                LoginScreen.userid = val.data['userid'];
                LoginScreen.email = val.data['email'];
                LoginScreen.username = val.data['username'];
                LoginScreen.profilepicture = val.data['profilepicture'];
                LoginScreen.isArtist = val.data['isArtist'];
                Navigator.of(context)
                    .popAndPushNamed('/homepage', arguments: []);
              } else {
                Navigator.of(context)
                    .popAndPushNamed('/homepage', arguments: []);
              }
            },
          );
          Fluttertoast.showToast(
            msg: val.data['msg'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          Navigator.of(context).popAndPushNamed('/homepage', arguments: []);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    tryToLogin();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('png/Login_Logo.png'),
                ),
                const SizedBox(height: 300),
                const CircularProgressIndicator(color: Color(0xFF6C43BC)),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: const GradientText(
                    'Yükleniyor..',
                    style: TextStyle(fontSize: 20),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6C43BC),
                        Color(0xFF72DFC5),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}