import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;

  const AppBlocs({@required this.app});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: WeatherRepository()),
        ),
      ],
      child: app,
    );
  }
}
