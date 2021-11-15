import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  FetchWeatherEvent();

  @override
  List<Object> get props => [];
}
