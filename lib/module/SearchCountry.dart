import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/module/searchScreen/cubit/search%20cubit.dart';
import 'package:weather/module/searchScreen/cubit/states.dart';

import '../models/weatherModel.dart';
import '../shared/components/components.dart';

class SearchCountry extends StatelessWidget {
  const SearchCountry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStates>
      (listener: (context,state){},
      builder: (context,state){
        weatherModel? model = SearchCubit.get(context).model;
        return ConditionalBuilder(
          condition: model != null && SearchCubit.get(context).translation != null,
          builder: (context)=> buildWeatherPage(model!,model.forecast!.forecastday[0],context,isSearch: true),
          fallback: (context)=> Scaffold(body: Center(child: CircularProgressIndicator())),

        );
      },);
  }
}
