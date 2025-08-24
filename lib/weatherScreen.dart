// import 'dart:ffi';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app_flu/Addtional_Info.dart';
import 'package:weather_app_flu/WeatherForecastCard.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_flu/secrets.dart';

// ignore: camel_case_types
class weatherScreen extends StatefulWidget {
  const weatherScreen({super.key});

  @override
  State<weatherScreen> createState() => _weatherScreenState();
}

class _weatherScreenState extends State<weatherScreen> {
  Future<Map<String, dynamic>> getCurrentData() async {
    try {
      String cityName = 'London';

      final res = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'));
      final date = jsonDecode(res.body);
      if (date['cod'] != '200') {
        throw 'An unexpected error occured';
      }
      return date;
      // setState(() {
      //   temp = date['list'][0]['main']['temp'];
      // });
    } catch (e) {
      throw e.toString();
    }
    // print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
          )
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getCurrentData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return CircularProgressIndicator();
            return Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 10,
                    )));
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          final data = snapshot.data!;
          final currenrWeatherData = data['list'][0];
          final currentTemp = currenrWeatherData['main']['temp'];
          final currentSky = currenrWeatherData['weather'][0]['main'];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                Container(
                  width: double.infinity,
                  child: Card(
                    // color: Color.fromARGB(255, 103, 103, 103),
                    elevation: 16,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                '$currentTemp k',
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                currentSky=='Cloud'||currentSky=='Rain'? Icons.cloud:Icons.sunny,
                                size: 50,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                '$currentSky',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WeatherForecastCard(
                        time: '3:',
                        icon: Icons.cloud,
                        temperature: '300.C',
                      ),
                      WeatherForecastCard(
                        time: '2:00',
                        icon: Icons.sunny,
                        temperature: '333',
                      ),
                      WeatherForecastCard(
                        time: '2:00',
                        icon: Icons.water,
                        temperature: '333',
                      ),
                      WeatherForecastCard(
                        time: '6:00',
                        icon: Icons.air_rounded,
                        temperature: '643',
                      ),
                      WeatherForecastCard(
                        time: '9:00',
                        icon: Icons.sunny,
                        temperature: '906',
                      ),
                      WeatherForecastCard(
                        time: '10:00',
                        icon: Icons.water,
                        temperature: '386',
                      ),
                    ],
                  ),
                ),
                // card

                const SizedBox(
                  height: 30,
                ),
                //info
                const Text(
                  'Addtional Info',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: [
                      Addtional_Info(
                        icon: Icons.water_drop_outlined,
                        climate: 'humid',
                        temperature: '94',
                      ),
                      Addtional_Info(
                        icon: Icons.air,
                        climate: 'wind speed',
                        temperature: '7.5',
                      ),
                      Addtional_Info(
                        icon: Icons.umbrella_outlined,
                        climate: 'pressure',
                        temperature: '1000',
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
