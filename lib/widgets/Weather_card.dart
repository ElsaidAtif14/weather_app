import 'package:flutter/material.dart';
import 'package:weather/View/forcast_page.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/widgets/Status_persents.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel model;
  final String? contry;
  const WeatherCard({super.key, required this.model, this.contry});

  String contrystates() {
    if (contry == null) {
      return "About Today";
    } else {
      return model.location.region;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            SizedBox(width: 24),
            Expanded(
              child: Text(
                contrystates(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xffF6FAFF),
                  fontSize: 28,

                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Image.network(
          model.current.imageurl,
          height: 160,
          width: 160,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            Text(
              model.current.condition,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${model.current.date.day}/${model.current.date.month}/${model.current.date.year}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Discover 7 days',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ForecastPage(weather: model,);
                    }));
                  },
                  icon: const Icon(Icons.trending_up, color: Colors.white,size: 32,),
                ),
              ],
            ),
            Text(
              model.current.temprature,
              style: TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Statuspersents(
              persepent: model.current.wind,
              statue: "wind",
              statepersent: 'km/h',
            ),
            Statuspersents(
              persepent: model.current.cloud,
              statue: "cloud",
              statepersent: '%',
            ),
            Statuspersents(
              persepent: model.current.humidity,
              statue: "humidity",
              statepersent: '%',
            ),
          ],
        ),
      ],
    );
  }
}
