import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';
import 'package:weather_app/weather_bloc/weather_event.dart';
import 'package:weather_app/weather_bloc/weather_state.dart';
import 'package:weather_app/weather_details.dart';
import 'data/models/weather_model.dart';
import 'weather_bloc/weather_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherBloc weatherBloc;
  Weather weatherModel;

  @override
  void initState() {
    super.initState();

    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(FetchWeatherEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather Forecast"),
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
    return Expanded(
      child: ListView.builder(
          itemCount: weather.list.length,
          itemBuilder: (context, index) {
            return InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherDetailsPage(
                            description:
                                '${weather.list[index].weather[0].description}',
                            date: '${weather.list[index].dtTxt}',
                            temperature:
                                weather.list[index].main.feelsLike - 273.15,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${weather.list[index].dtTxt}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'CenturyGothicBold'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${weather.list[index].weather[0].description}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'CenturyGothicBold'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${(weather.list[index].main.feelsLike - 273.15).toStringAsFixed(1)} \u2103',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'CenturyGothicBold'),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            );
          }),
    );
  }

  buildLoading() {
    return Container(
      child: Column(
        children: [
          SpinKitDoubleBounce(color: Colors.blue),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
