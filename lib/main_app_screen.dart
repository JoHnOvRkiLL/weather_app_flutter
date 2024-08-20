import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather_app/add_info.dart';
import 'package:weather_app/hourley_forecast_cards.dart';
import 'package:weather_app/main_weather_card.dart';
import 'package:http/http.dart' as http;

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  Future<Map<String, dynamic>> getCurrWeather() async {
    try {
      String cityName = "Pune";
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=${"yourAPI_Key"}'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw "Gadbad Ho Gayi Bhai";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final double currTemp = data['list'][0]['main']['temp'] - 273;
          final String currCondition = data['list'][0]['weather'][0]['main'];
          final int currPressure = data['list'][0]['main']['pressure'];
          final int currHumidity = data['list'][0]['main']['humidity'];
          final double windSpeed = data['list'][0]['wind']['speed'];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main Card
                MainWeatherCard(
                  temperature: "${currTemp.toStringAsPrecision(4)}°C",
                  condition: currCondition,
                  icon: (currCondition == 'Clouds' || currCondition == 'Rain')
                      ? Icons.cloud_rounded
                      : Icons.wb_sunny_rounded,
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 8),
                  child: Text(
                    "Hourley Forecast",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                //forecast cards
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final hourleyForecast = data['list'][index + 1];
                        return HourleyForecastCards(
                          time: hourleyForecast['dt_txt']
                              .toString()
                              .substring(11, 16),
                          temperature:
                              "${(hourleyForecast['main']['temp'] - 273).toStringAsPrecision(3)}°C",
                          icon: (hourleyForecast['weather'][0]['main']
                                          .toString() ==
                                      "Rain" ||
                                  hourleyForecast['weather'][0]['main']
                                          .toString() ==
                                      "Clouds")
                              ? Icons.cloud_rounded
                              : Icons.wb_sunny_rounded,
                        );
                      }),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 8),
                  child: Text(
                    "Additional Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                //More info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AddInfo(
                      icon: Icons.water_drop,
                      label: "Humidity",
                      value: "$currHumidity%",
                    ),
                    AddInfo(
                      icon: Icons.unfold_more_double,
                      label: "Pressure",
                      value: (currPressure / 1000).toStringAsPrecision(3),
                    ),
                    AddInfo(
                      icon: Icons.wind_power,
                      label: "Wind Speed",
                      value: "${(windSpeed * 1.60).toStringAsPrecision(3)}km/h",
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
