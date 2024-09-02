import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/models/constants.dart';
import 'package:weatherapp/ui/welcome.dart';
import 'package:weatherapp/widgets/weather_item.dart';

class DetailPage extends StatefulWidget {
  final int selectedId;
  final String location;
  final dynamic consolidatedWeekWeatherList;

  const DetailPage(
      {Key? key,
        required this.consolidatedWeekWeatherList,
        required this.selectedId,
        required this.location,})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String imageUrl = '';
  int temperature = 0;
  String weatherStateName = 'Loading..';

  @override
  void initState() {
    super.initState();

    // Extracting the selected day's weather details
    var selectedDayWeather = widget.consolidatedWeekWeatherList[widget.selectedId];

    // Assigning the extracted values to the respective variables
    temperature = selectedDayWeather['day']['avgtemp_c'].round();
    weatherStateName = selectedDayWeather['day']['condition']['text'];
    imageUrl = 'assets/${weatherStateName.toLowerCase()}.png';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Constants myConstants = Constants();

    // Create a shader linear gradient
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Scaffold(
      backgroundColor: myConstants.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: myConstants.secondaryColor,
        foregroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
            widget.location,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Welcome()));
                },
                icon: const Icon(Icons.settings)),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              height: 150,
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.consolidatedWeekWeatherList.length,
                itemBuilder: (BuildContext context, int index) {
                  var dayData = widget.consolidatedWeekWeatherList[index];
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
                        color: index == widget.selectedId
                            ? Colors.white
                            : const Color(0xff9ebcf9),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 1),
                            blurRadius: 10,
                            color: Colors.blue.withOpacity(.3),
                          ),
                        ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            newDate,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: index == widget.selectedId
                                ? Colors.blue
                                : Colors.white,
                            ),
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
                              color: index == widget.selectedId
                                  ? Colors.blue
                                  : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .55,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  )),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      width: size.width * .7,
                      height: 175,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.center,
                              colors: [
                                Color(0xffa9c1f5),
                                Color(0xff6696f5),
                              ]),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(.1),
                              offset: const Offset(0, 25),
                              blurRadius: 3,
                              spreadRadius: -10,
                            ),
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
                            ),
                          ),
                          Positioned(
                              top: 120,
                              left: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  weatherStateName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              )),

                          Positioned(
                            top: 20,
                            right: 20,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${temperature}',
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              const Positioned(
               top: 160,
                left: 110,
                right: 110,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Today\'s 24 Hour',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
              ),
                  Positioned(
                    top: 200,
                    bottom: 10,
                    left: 20,
                    child: SizedBox(
                      height: 200,
                      width: size.width * .9,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.consolidatedWeekWeatherList[0]['hour'].length,
                        itemBuilder: (BuildContext context, int index) {
                          // Extract the relevant data for each hour
                          var hourData = widget.consolidatedWeekWeatherList[0]['hour'][index];
                          var hourTime = DateFormat('HH:mm').format(DateTime.parse(hourData['time']));
                          var temp = hourData['temp_c'].round();
                          var weatherIcon = hourData['condition']['icon'];
                          var weatherDescription = hourData['condition']['text'];

                          return Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              right: 10,
                              bottom: 5,
                            ),
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: myConstants.secondaryColor,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Display time
                                  Text(
                                    hourTime,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Color(0xff6696f5),
                                    ),
                                  ),
                                  // Display temperature
                                  Text(
                                    '$temp°C',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  // Display weather icon and description
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https:$weatherIcon',
                                        width: 30,
                                      ),
                                      Text(
                                        weatherDescription,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}