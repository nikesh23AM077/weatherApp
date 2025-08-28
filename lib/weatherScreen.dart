// import 'dart:ffi';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                IconButton(onPressed: () {
                  setState(() {
                    
                  });
                }, icon: const Icon(Icons.refresh)),
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

          //variales
          final data = snapshot.data!;
          final currenrWeatherData = data['list'][0];
          final currentTemp = currenrWeatherData['main']['temp'];
          final currentSky = currenrWeatherData['weather'][0]['main'];
          final currentPressure = currenrWeatherData['main']['pressure'];
          final currentWindSpeed = currenrWeatherData['wind']['speed'];
          final currentHumidity = currenrWeatherData['main']['humidity'];

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
                                currentSky == 'Cloud' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
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
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         WeatherForecastCard(
                //           time: data['list'][i+1]['dt'].toString(),
                //           icon: data['list'][i+1]['weather'][0]['main'] =='Clouds'||data['list'][i+1]['weather'][0]['main'] =='Rain'? Icons.cloud:Icons.sunny,
                //           temperature:data['list'][i+1]['main']['temp'].toString(),
                //         ),
                //     ],
                //   ),
                // ),
                // card
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final hourlyForecast = data['list'][index + 1];
                        final hourlySky =
                            data['list'][index + 1]['weather'][0]['main'];
                        final hourlyTemp =
                            hourlyForecast['main']['temp'].toString();
                        final time = DateTime.parse(hourlyForecast['dt_txt']);
                        return WeatherForecastCard(
                          time: DateFormat('j').format(time),
                          icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          temperature: hourlyTemp,
                        );
                      }),
                ),
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
                        climate: 'humidity',
                        temperature: '$currentHumidity',
                      ),
                      Addtional_Info(
                        icon: Icons.air,
                        climate: 'wind speed',
                        temperature: '$currentWindSpeed',
                      ),
                      Addtional_Info(
                        icon: Icons.beach_access,
                        climate: 'pressure',
                        temperature: '$currentPressure',
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
