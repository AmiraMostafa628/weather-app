import 'dart:core';

class weatherModel {
  Location? location;
  Current? current;
  Forecast? forecast;

  weatherModel.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    current = Current.fromJson(json['current']);
    forecast = Forecast.fromJson(json['forecast']);
  }
}

class Location {
  String? name;
  DateTime? localtime;

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    localtime = DateTime.parse(json['localtime']);
  }
}

class Current {
  double? tempC;
  double? tempF;
  int? humidity;
  dynamic feelslike_c;
  dynamic uv;
  Condition? condition;

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    humidity = json['humidity'];
    feelslike_c = json['feelslike_c'];
    uv = json['uv'];
    condition = Condition.fromJson(json['condition']);
  }

}

class Condition {
  String? text;
  String? icon;

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {
  List<Forecastday> forecastday=[];

  Forecast.fromJson(Map<String, dynamic> json) {
      json['forecastday'].forEach((v) {
        forecastday.add( Forecastday.fromJson(v));
      });
    }
}

class Forecastday {
  DateTime? date;
  Day? day;
  List<Hour> hour=[];

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    day =  Day.fromJson(json['day']);
      json['hour'].forEach((v) {
        hour.add(Hour.fromJson(v));
      });
    }
}

class Day {
  double? maxtempC;
  double? maxtempF;
  double? mintempC;
  double? mintempF;
  Condition? condition;

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    maxtempF = json['maxtemp_f'];
    mintempC = json['mintemp_c'];
    mintempF = json['mintemp_f'];
    condition = Condition.fromJson(json['condition']);
  }

}

class Hour {
  DateTime? time;
  double? tempC;
  double? tempF;
  Condition? condition;
  Hour(
      {
        this.time,
        this.tempC,
        this.tempF,
        this.condition,});

  Hour.fromJson(Map<String, dynamic> json) {
    time = DateTime.parse(json['time']);
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    condition =Condition.fromJson(json['condition']);

  }
}
