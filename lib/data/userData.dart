import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadaf/data/models/auth_model.dart';
import 'package:hadaf/ui/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setUserData({@required AuthModel data})async{
  await setToken(token: data.token);
  await setId(userId: data.id);
  return true ;
}

Future<bool> setToken({@required String token }) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString("token", token);
  return true;
}

Future<String> getToken() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String token = _prefs.getString("token")??null;
  return token;
}

Future<bool> setId({@required int userId}) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
   _prefs.setInt("userId", userId);
  return true;
}

Future<int> getUserId() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  int userId = _prefs.getInt("userId")??-1;
  return userId;
}

void logout( BuildContext context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.clear();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
}










