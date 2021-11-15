import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/functions.dart';

class WeatherDetailsPage extends StatefulWidget {
  final String description;
  final DateTime date;
  final double temperature;
  final String city;
  final int humidity;
  final double speed;
  final String image;
  final double maximumTemperature;
  final double minimunTemperature;
  final int pressure;
  final double rain;

  WeatherDetailsPage(
      {Key key,
      @required this.description,
      @required this.date,
      @required this.temperature,
      @required this.city,
      @required this.humidity,
      @required this.speed,
      @required this.image,
      @required this.maximumTemperature,
      @required this.minimunTemperature,
      @required this.pressure,
      this.rain})
      : super(key: key);

  @override
  _WeatherDetailsPageState createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on),
                      Center(
                          child: Text('Harare',
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    DateFormat.MMMMEEEEd().format(widget.date) +
                        ' ' +
                        DateFormat.jm().format(widget.date),
                    //  '${weather.list[index].dtTxt}',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'CenturyGothicBold'),
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                                '${widget.temperature.toStringAsFixed(1)} \u2103',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(
                                widget.temperature > 25
                                    ? "Hot"
                                    : widget.temperature < 10
                                        ? "Cold"
                                        : "Warm",
                                style: TextStyle(
                                    color: widget.temperature > 25
                                        ? Colors.red
                                        : widget.temperature < 10
                                            ? Colors.blue
                                            : Colors.grey[800],
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              widget.image,
                            ),
                            Text(getWeatherDescription(widget.description)
                                //'${}',
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Minimun Temp"),
                        Text(
                            '${(widget.minimunTemperature).toStringAsFixed(1)} \u2103'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Maximum Temp"),
                        Text(
                            '${(widget.maximumTemperature).toStringAsFixed(1)} \u2103'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Humidity"),
                        Text('${widget.humidity}%'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Wind speed"),
                        Text('${widget.speed} Mph'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Pressure"),
                        Text('${widget.pressure} Pa'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rain"),
                        Text('${widget.rain ?? 0.00}'),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
