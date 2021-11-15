import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/app_blocs.dart';
import 'package:weather_app/app_repositories.dart';
import 'package:weather_app/home.dart';

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
