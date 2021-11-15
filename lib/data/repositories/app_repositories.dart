import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;
import 'package:weather_app/data/repositories/weather_repository.dart';

class AppRepositories extends StatelessWidget {
  final Widget appBloc;

  const AppRepositories({
    @required this.appBloc,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => WeatherRepository())],
      child: appBloc,
    );
  }
}
