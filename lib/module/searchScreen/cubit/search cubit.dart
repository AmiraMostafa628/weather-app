import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:translator/translator.dart';
import 'package:weather/models/weatherModel.dart';
import 'package:weather/module/searchScreen/cubit/states.dart';
import 'package:weather/shared/cubit/state.dart';
import 'package:weather/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialStates());

  static SearchCubit get(context)=> BlocProvider.of(context);

  weatherModel? model;
  final translator = GoogleTranslator();
  var translation;
  void getMycountryWeather(String country)
  {
    emit(getSearchCountryWeatherLoadingStates());
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

      emit(getSearchCountryWeatherSuccessStates());
    }).catchError((error){
      print(error.toString());
      emit(getSearchCountryWeatherErrorStates());
    });
  }

}