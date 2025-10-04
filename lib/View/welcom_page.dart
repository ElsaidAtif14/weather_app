import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/View/home_page.dart';
import 'package:weather/View/main_screen.dart';

class WelcomPage extends StatelessWidget {
  const WelcomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff04082D),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Animation
           SizedBox(height: 32,),
          Center(
            child: Lottie.asset(
              "Assets/animation/Animated Cloud.json",
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),

          // Title & Description
          Column(
            children: const [
             
              Text(
                "Daily\nWeather",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Text(
                'Get to Know your Weather \nmaps and reader precipitation\nForcast',
                style: TextStyle(
                  color: Color.fromARGB(255, 124, 119, 119),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          // Button
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context){
                return MainScreen();
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff38ACFF),
              foregroundColor: Colors.white,
              minimumSize: const Size(150, 50),
            ),
            child: const Text(
              "Get Started",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
