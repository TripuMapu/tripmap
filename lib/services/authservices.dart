import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  String ip = "192.168.1.12";
  // ignore: unnecessary_new
  Dio dio = new Dio();

  login(username, password) async {
    try {
      return await dio.post('http://$ip:5554/login',
          data: {
            "username": username,
            "password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  adduser(username, password, email) async {
    try {
      return await dio.post('http://mobileapp-server.herokuapp.com/adduser',
          data: {
            "username": username,
            "password": password,
            "email": email,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  getinfo(usertoken) async {
    try {
      return await dio.get('http://$ip:5554/getinfo',
          options: Options(headers: {"Authorization": 'Bearer $usertoken'}));
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<List> getlocationcomments(int locationID) async {
    try {
      final res = await dio.post(
        'http://$ip:5554/getcomments',
        data: {'locationId': locationID},
      );
      if (res.data['success']) {
        return res.data['array'];
      } else {
        return List.empty();
      }
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<List> getdistricts() async {
    try {
      final res = await dio.post('http://$ip:5554/getdistricts');
      if (res.data['success']) {
        return res.data['array'];
      } else {
        return List.empty();
      }
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<List> getlocations(int districtid) async {
    try {
      final res = await dio.post('http://$ip:5554/findlocations',
          data: {'locationdistrictId': districtid});
      if (res.data['success']) {
        return res.data['array'];
      } else {
        return List.empty();
      }
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<List> gettypes() async {
    try {
      final res = await dio.post('http://$ip:5554/gettypes');
      if (res.data['success']) {
        return res.data['array'];
      } else {
        return List.empty();
      }
    } on DioError catch (e) {
      rethrow;
    }
  }

  Future<List> getalllocations() async {
    try {
      final res = await dio.post('http://$ip:5554/getalllocations');
      if (res.data['success']) {
        return res.data['array'];
      } else {
        return List.empty();
      }
    } on DioError catch (e) {
      rethrow;
    }
  }

  tryserver() async {
    try {
      return await dio.get('http://mobileapp-server.herokuapp.com/testserver');
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: e.response!.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
