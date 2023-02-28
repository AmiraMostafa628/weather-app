import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/module/searchScreen/cubit/states.dart';
import 'package:weather/shared/cubit/cubit.dart';
import 'package:weather/shared/cubit/state.dart';
import '../../shared/components/components.dart';
import '../SearchCountry.dart';
import 'cubit/search cubit.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey =GlobalKey<FormState>();

  Widget build(BuildContext context) {

      return BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(
                  color: Colors.black ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (value)
                      {
                        if(value.isEmpty)
                          return 'Enter text to search';
                      },
                      onSubmit:(text)
                      {
                        SearchCubit.get(context).getMycountryWeather(text);
                        NavigateTo(context, SearchCountry());
                        searchController.text=="";
                      },
                      label: 'Search',
                      prefix: Icons.search,

                    ),
                    SizedBox(
                      height: 20.0,
                    ),



                  ],
                ),
              ),
            ),
          );
        },
      );

  }
}