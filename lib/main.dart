import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weather/layout/HomeLayout.dart';
import 'package:weather/module/searchScreen/cubit/search%20cubit.dart';
import 'package:weather/shared/cubit/cubit.dart';
import 'package:weather/shared/network/bloc_observer.dart';
import 'package:weather/shared/network/local/cache_helper.dart';
import 'package:weather/shared/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> weatherCubit()..getCurrentLocation()),
        BlocProvider(create:(context)=> SearchCubit()),
      ],
      child: ResponsiveSizer(
       builder: (context, orientation, screenType) {
         return MaterialApp(
           debugShowCheckedModeBanner: false,
           themeMode: ThemeMode.light,
           home: HomePage(),
         );
      }
      ),
    );
  }
}
