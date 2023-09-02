import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/LoginScreen/LoginScreen.dart';
import 'package:userapp/introduction_animation/introduction_animation_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLogin()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? studid=pref.getString("studid");
    if(studid ==null)
      {
        return false;
      }
    return true;

}


  @override
  Widget build(BuildContext context) {

  if(checkLogin()==true)
    {
      return  Scaffold(body:LoginScreen());
    }
  else
    {
      return  Scaffold(body:IntroductionAnimationScreen());
    }



  }
}
