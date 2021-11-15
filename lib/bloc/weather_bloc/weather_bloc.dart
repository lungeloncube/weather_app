import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;
  Weather weatherModel;

  WeatherBloc({@required this.weatherRepository}) : super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
    }

    try {
      weatherModel = await weatherRepository.getWeather();

      yield WeatherLoadedState(weatherModel: weatherModel);
    } catch (e) {
      yield WeatherErrorState(message: "Error occured while fetching weather");
    }
  }
}
