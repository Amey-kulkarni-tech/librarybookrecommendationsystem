import 'package:LRA/HomeScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AnimatedSplashScreen(
            splash: Column(
              children: [
            ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Image.asset(
        "assets/bookicon.png",
        width:60,
        height:60,
        fit:BoxFit.fill,
        )
        ),
                SizedBox(height: 20,),
                const Text("Library Recommendation App",
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
               SizedBox(height: 20,),
                const Text("Admin App",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)

              ],
            ),
            nextScreen: HomeScreen(),
            splashIconSize: 150,
          splashTransition: SplashTransition.scaleTransition,
        ),
      ),
    );
  }
}
