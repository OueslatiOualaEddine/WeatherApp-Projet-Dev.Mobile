import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weatherapp/models/city.dart';
import 'package:weatherapp/models/constants.dart';
import 'package:weatherapp/ui/detail_page.dart';
import 'package:weatherapp/widgets/weather_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myConstants = Constants();

  // Initialization
  int temperature = 0;
  int maxTemp = 0;
  String weatherStateName = 'Loading..';
  int humidity = 0;
  int windSpeed = 0;
  int pression = 0;

  String imageUrl = '';
  var currentDate = 'Loading..';
  String location = 'Tunis'; // Our default city

  dynamic consolidatedWeatherList;
  dynamic consolidatedWeekWeatherList;

  // Get the cities and selected cities data
  var selectedCities = City.getSelectedCities();
  List<String> cities = [
    'Tunis'
  ]; // The list to hold our selected cities. Default is Tunis

  // API call URL
  String apiKey = '56a084a19a5a4ab48f4111842243008';
  String weatherUrl =
      'https://api.weatherapi.com/v1/current.json?q=';
  String weekweatherUrl =
      'https://api.weatherapi.com/v1/forecast.json?q=';

  // Fetch weather data
  void fetchWeatherData(String location) async {
    var weatherResult = await http.get(Uri.parse(
        '$weatherUrl$location&key=$apiKey'));
    var result = json.decode(weatherResult.body);

    setState(() {
      temperature = result['current']['temp_c'].round();
      weatherStateName = result['current']['condition']['text'];
      humidity = result['current']['humidity'];
      windSpeed = result['current']['wind_kph'].round();
      pression = result['current']['pressure_mb'].round();
      imageUrl = 'assets/${weatherStateName.toLowerCase()}.png';

      consolidatedWeatherList = [result];
    });
  }

  // Fetch weather data for the week
  void fetchWeekWeatherData(String location) async {
    var weekWeatherResult = await http.get(Uri.parse(
        '$weekweatherUrl$location&days=7&key=$apiKey'));
    var result = json.decode(weekWeatherResult.body);

    setState(() {
      consolidatedWeekWeatherList = result['forecast']['forecastday'];
    });
  }

  @override
  void initState() {
    fetchWeatherData(cities[0]);
    fetchWeekWeatherData(cities[0]);

    var myDate = DateTime.now();
    currentDate = DateFormat('EEEE, d MMMM').format(myDate);


    // For all the selected cities from our City model, extract the city and add it to our original cities list
    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
    super.initState();
  }

  // Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    // Create a size variable for the media query
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Our profile image
              const Text(
                "Weather App",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              // Our location dropdown
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/pin.png',
                    width: 20,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: location,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: cities.map((String location) {
                          return DropdownMenuItem(
                              value: location, child: Text(location));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            location = newValue!;
                            fetchWeatherData(location);
                            fetchWeekWeatherData(location);
                          });
                        }),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              currentDate,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: myConstants.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: myConstants.primaryColor.withOpacity(.5),
                      offset: const Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -12,
                    )
                  ]),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -20,
                    left: 40,
                    child: Image.asset(
                      imageUrl,
                      width: 130,
                    )
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Text(
                      weatherStateName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            temperature.toString(),
                            style: TextStyle(
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()..shader = linearGradient,
                            ),
                          ),
                        ),
                        Text(
                          'o',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weatherItem(
                    text: 'Wind Speed',
                    value: windSpeed,
                    unit: 'kph',
                    imageUrl: 'assets/windspeed.png',
                  ),
                  weatherItem(
                      text: 'Humidity',
                      value: humidity,
                      unit: '%',
                      imageUrl: 'assets/humidity.png'),
                  weatherItem(
                    text: 'Pression',
                    value: pression,
                    unit: 'MB',
                    imageUrl: 'assets/pression.png',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Further UI adjustments can be made here for forecast display, etc.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Next 7 Days',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: myConstants.primaryColor),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: consolidatedWeekWeatherList.length,
                itemBuilder: (BuildContext context, int index) {
                  var dayData = consolidatedWeekWeatherList[index];
                  var futureWeatherIcon = dayData['day']['condition']['icon'];
                  var weatherUrl = "https:$futureWeatherIcon";

                  var parsedDate = DateTime.parse(dayData['date']);
                  var newDate = DateFormat('EEEE')
                      .format(parsedDate)
                      .substring(0, 3); // Formatted date

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.only(right: 20),
                    width: 80,
                    decoration: BoxDecoration(
                        color: myConstants.primaryColor,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 10,
                            color: myConstants.primaryColor,
                          ),
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DetailPage(
                              consolidatedWeekWeatherList: consolidatedWeekWeatherList,
                              selectedId: index,
                              location: location,)));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            newDate,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.network(
                            weatherUrl,
                            width: 40,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${dayData['day']['maxtemp_c'].round()}°C',
                            style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
