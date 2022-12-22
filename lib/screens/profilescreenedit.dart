import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripmap/screens/loadingscreen.dart';

class ProfileScreenEdit extends StatelessWidget {
  const ProfileScreenEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(LineAwesomeIcons.arrow_left),
              color: const Color(0xFF6C43BC),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  SharedPreferences.getInstance().then(
                    (prefs) {
                      prefs.setString('userName', '');
                      prefs.setString('password', '');
                    },
                  );
                  LoadingScreen.isLogined = false;
                  Navigator.of(context).popUntil((route) => false);
                  Navigator.of(context).pushNamed('/loading', arguments: []);
                },
                icon: const Icon(Icons.logout),
                color: const Color(0xFF6C43BC),
              )
            ],
            title: Container(
              padding: const EdgeInsets.only(top: 5),
              width: 150,
              child: Image.asset(
                'png/DuzLogo.PNG',
                height: 50,
                width: 60,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  transform: Matrix4.translationValues(-140, 25, 0),
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
                  child: const Text("Kullanıcı Adı Değiştir",
                      style: TextStyle(
                          color: Color(0xFF6C43BC),
                          decoration: TextDecoration.underline)),
                ),
                Form(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      //controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Yeni Kullanıcı Adı',
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
                      validator: (val) {
                        if (val != null) {
                          if (val.isEmpty) {
                            return 'Boş Bırakılamaz';
                          } else {
                            return null;
                          }
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 300),
                  child: Container(
                    height: 35,
                    width: 75,
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'KAYDET',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(-140, 25, 0),
                  child: const Text("Parola İşlemleri",
                      style: TextStyle(
                          color: Color(0xFF6C43BC),
                          decoration: TextDecoration.underline)),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Eski Parola',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF6C43BC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF72DFC5)),
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
                    validator: (val) {
                      if (val != null) {
                        if (val.isEmpty) {
                          return 'Boş Bırakılamaz';
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Yeni Parola',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF6C43BC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF72DFC5)),
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
                    validator: (val) {
                      if (val != null) {
                        if (val.isEmpty) {
                          return 'Boş Bırakılamaz';
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Parolayı Doğrula',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF6C43BC)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFF72DFC5)),
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
                    validator: (val) {
                      if (val != null) {
                        if (val.isEmpty) {
                          return 'Boş Bırakılamaz';
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 300),
                  child: Container(
                    height: 35,
                    width: 75,
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'KAYDET',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
