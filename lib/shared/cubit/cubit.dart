import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:translator/translator.dart';
import 'package:weather/models/weatherModel.dart';
import 'package:weather/shared/cubit/state.dart';
import 'package:weather/shared/network/remote/dio_helper.dart';

class weatherCubit extends Cubit<weatherStates>{
  weatherCubit():super(weatherInitialStates());

  static weatherCubit get(context)=> BlocProvider.of(context);

  Position? currentPosition;
  String? currentAddress;
  Future<Position?> getCurrentLocation()async {

    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');

    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high, forceAndroidLocationManager: true)
        .then((Position position) {
        currentPosition = position;
        getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {

      List<Placemark>? placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude,
        currentPosition!.longitude,

      );
        Placemark place = placemarks[0];
        currentAddress = "${place.locality}";
        print(currentAddress);
        if(currentAddress=="Samanoud"||currentAddress=="مدينة سمنود"||currentAddress=="Samannoud City")
          getMycountryWeather("Samannud");
        else
          getMycountryWeather(currentAddress!);

        emit(getMycountryStates());


  }

  weatherModel? model;
  final translator = GoogleTranslator();
  var translation;
  void getMycountryWeather(String country)
  {
    emit(getMycountryWeatherLoadingStates());
    DioHelper.getData(
        url: 'v1/forecast.json',
        query:{
          'q':'$country',
          'Key':'ab1650d03e8442898dc203149232102',
          'days':'4',
        }
    ).then((value)async {
      model=weatherModel.fromJson(value.data);
      print(model!.location!.name);
       translation = await translator.translate("${model!.location!.name}", to: 'en');

      emit(getMycountryWeatherSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(getMycountryWeatherErrorStates());
    });
  }

}