import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/weatherModel.dart';
import 'package:weather/shared/cubit/cubit.dart';
import 'package:weather/shared/cubit/state.dart';

import '../shared/components/components.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<weatherCubit,weatherStates>
      (listener: (context,state){},
        builder: (context,state){
        weatherModel? model = weatherCubit.get(context).model;
        return ConditionalBuilder(
          condition: model != null && weatherCubit.get(context).translation != null,
          builder: (context)=> buildWeatherPage(model!,model.forecast!.forecastday[0],context,isSearch: false),
          fallback: (context)=> Scaffold(body: Center(child: CircularProgressIndicator())),

        );
        },);
  }

}
