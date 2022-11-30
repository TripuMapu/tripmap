import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmap/screens/registerscreen.dart';
import 'package:tripmap/services/authservices.dart';
export 'loginscreen.dart';

class LoginScreen extends StatefulWidget {
  static var username, email, profilepicture, userid;
  static bool isArtist = false;

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var username, password;
  final _formKey = GlobalKey<FormState>();
  OverlayEntry? entry;

  void showLoadingOverlay() {
    final overlay = Overlay.of(context)!;

    entry = OverlayEntry(
      builder: (context) => buildLoadingOverlay(),
    );

    overlay.insert(entry!);
  }

  void hideLoadingOverlay() {
    entry!.remove();
    entry = null;
  }

  Widget buildLoadingOverlay() => const Material(
        color: Colors.transparent,
        elevation: 8,
        child: Center(
          child: CircularProgressIndicator(
              color: Color.fromARGB(255, 163, 171, 192)),
        ),
      );

  void _handleRemeberme() {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setString('userName', nameController.text);
        prefs.setString('password', passwordController.text);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Giriş Yap'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                    child: Image.asset('png/Login_Logo.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.account_circle),
                        labelText: 'Kullanıcı Adı',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xFF6C43BC)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xFF72DFC5)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      onChanged: (val) {
                        username = val;
                      },
                      validator: (val) {
                        if (val != null) {
                          if (val.isEmpty) {
                            return 'Boş Bırakılamaz';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.key),
                        labelText: 'Şifre',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xFF6C43BC)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xFF72DFC5)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      onChanged: (val) {
                        password = val;
                      },
                      validator: (val) {
                        if (val != null) {
                          if (val.isEmpty) {
                            return 'Boş Bırakılamaz';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/forgotpassword', arguments: []);
                    },
                    child: const Text(
                      'Şifremi Unuttum',
                      style: TextStyle(
                        color: Color(0xFF6C43BC),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF6C43BC),
                            Color(0xFF72DFC5),
                          ],
                          stops: [
                            0.2,
                            1.0,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          child: const Text('Giriş Yap'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => showLoadingOverlay());
                              });
                              AuthService().login(username, password).then(
                                (val) {
                                  if (val.data['success']) {
                                    AuthService()
                                        .getinfo(val.data['token'])
                                        .then(
                                      (val) {
                                        if (val.data['success']) {
                                          //LoadingScreen.isLogined = true;
                                          LoginScreen.userid =
                                              val.data['userid'];
                                          LoginScreen.email = val.data['email'];
                                          LoginScreen.username =
                                              val.data['username'];
                                          LoginScreen.profilepicture =
                                              val.data['profilepicture'];
                                          LoginScreen.isArtist =
                                              val.data['isArtist'];
                                          _handleRemeberme();
                                          setState(() {
                                            hideLoadingOverlay();
                                          });
                                          //LoadingScreen.currentRoute = '/homepage';
                                          Navigator.of(context)
                                              .popUntil((route) => false);
                                          Navigator.of(context).pushNamed(
                                              '/homepage',
                                              arguments: []);
                                        } else {
                                          Fluttertoast.showToast(
                                            msg: val.data['msg'],
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          setState(() {
                                            hideLoadingOverlay();
                                          });
                                        }
                                      },
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: val.data['msg'],
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    setState(() {
                                      hideLoadingOverlay();
                                    });
                                  }
                                },
                              );
                            }
                          },
                        ),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6C43BC),
                          Color(0xFF72DFC5),
                        ],
                        stops: [
                          0.2,
                          1.0,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: TextButton(
                        child: const Text(
                          'Kayıt Ol',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}