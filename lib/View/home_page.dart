import 'package:flutter/material.dart';
import 'package:weather/widgets/Weather_card_view_Builder.dart';
import 'package:weather/widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff04082D),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      drawer: const Drawer(backgroundColor: Colors.blue),
      body: WeatherCardViewBuilder()
    );
  }
}



