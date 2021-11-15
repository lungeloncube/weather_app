import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final Weather weatherModel;

  WeatherLoadedState({@required this.weatherModel});

  @override
  List get props => [weatherModel];
}

class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
