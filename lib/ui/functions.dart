import 'package:flutter/material.dart';

String getWeatherDescription(String description) {
  if (description == 'Description.BROKEN_CLOUDS') {
    return "Broken clouds";
  } else if (description == 'Description.CLEAR_SKY') {
    return "Clear sky";
  } else if (description == 'Description.FEW_CLOUDS') {
    return "Few clouds";
  } else if (description == 'Description.LIGHT_RAIN') {
    return "Light rain";
  } else if (description == 'Description.OVERCAST_CLOUDS') {
    return "Overcast clouds";
  } else if (description == 'Description.SCATTERED_CLOUDS') {
    return "Scattered clouds";
  } else {
    return "Clear sky";
  }
}

Color getWeatherStatus(double temperature) {
  if (temperature > 25) {
    return Colors.red;
  } else if (temperature < 10) {
    return Colors.blue;
  } else {
    return Colors.grey[800];
  }
}

String getMain(String main) {
  if (main == "MainEnum.CLEAR") {
    return "Clear";
  } else if (main == "MainEnum.CLOUDS") {
    return "Clouds";
  } else if (main == "MainEnum.RAIN") {
    return "Rain";
  } else {
    return "Clear";
  }
}
