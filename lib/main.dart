import 'package:flutter/material.dart';
import 'package:weather_app/bloc/app_blocs.dart';
import 'package:weather_app/data/repositories/app_repositories.dart';
import 'package:weather_app/ui/home.dart';

void main() {
  runApp(AppRepositories(
    appBloc: AppBlocs(app: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}
