import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_bloc/weather_state.dart';
import 'package:weather_app/ui/functions.dart';
import 'package:weather_app/ui/weather_details.dart';
import '../data/models/weather_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherBloc weatherBloc;
  Weather weatherModel;
  String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = 'https://openweathermap.org/img/w/';

    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(FetchWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Text("Weather Forecast App"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Container(
              child: BlocListener<WeatherBloc, WeatherState>(
                listener: (context, state) {
                  if (state is WeatherErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitial) {
                      return buildLoading();
                    } else if (state is WeatherLoadingState) {
                      return buildLoading();
                    } else if (state is WeatherLoadedState) {
                      return buildWeatherList(state.weatherModel);
                    } else if (state is WeatherErrorState) {
                      return Container(
                        height: 600,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "An error occured while fetching the weather",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontFamily: 'CenturyGothicBold',
                            ),
                          ),
                        ),
                      );

                      // buildErrorUi(state.message);
                    }
                    return Container();
                  },
                ),
              ),
            ))));
  }

  Widget buildWeatherList(Weather weather) {
    return ListView.builder(
        itemCount: weather.list.length,
        itemBuilder: (context, index) {
          return InkResponse(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WeatherDetailsPage(
                          pressure: weather.list[index].main.pressure,
                          description:
                              '${weather.list[index].weather[0].description}',
                          date: weather.list[index].dtTxt,
                          temperature:
                              weather.list[index].main.feelsLike - 273.15,
                          speed: weather.list[0].wind.speed,
                          city: weather.city.name,
                          humidity: weather.list[index].main.humidity,
                          image: imageUrl +
                              weather.list[index].weather[0].icon +
                              '.png',
                          maximumTemperature:
                              weather.list[index].main.tempMax - 273.15,
                          minimunTemperature:
                              weather.list[index].main.tempMin - 273.15,
                        )),
              );
            },
            child: Container(
              child: Card(
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 0,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Text(
                                    DateFormat.MMMMEEEEd()
                                        .format(weather.list[index].dtTxt),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'CenturyGothicBold'),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    DateFormat.jm()
                                        .format(weather.list[index].dtTxt),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'CenturyGothicBold'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                '${(weather.list[index].main.feelsLike - 273.15).toStringAsFixed(1)} \u2103',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: getWeatherStatus(
                                        weather.list[index].main.feelsLike -
                                            273.15),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'CenturyGothicBold'),
                              ),
                            ),
                            Image.network(
                                '$imageUrl${weather.list[index].weather[0].icon}.png'),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
  }

  buildLoading() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Center(
        child: Column(
          children: [
            Container(
                height: height * 0.6,
                child: Center(child: SpinKitDoubleBounce(color: Colors.blue))),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
