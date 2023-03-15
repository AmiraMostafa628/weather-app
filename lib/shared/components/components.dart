import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:weather/layout/HomeLayout.dart';
import 'package:weather/module/searchScreen/cubit/search%20cubit.dart';
import 'package:weather/module/searchScreen/searchScreen.dart';
import 'package:weather/shared/cubit/cubit.dart';

import '../../models/weatherModel.dart';

Widget myDivider() =>Padding(
  padding: const EdgeInsetsDirectional.only(start: 10.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[100],
  ),
);

Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator? validate,
  Function? onSubmit,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword =false,
  Function? suffixPressed,
  bool isClickable = true,
  Color? color,
  Color? iconColor,
  double radius = 10.0,
}

    ) => TextFormField(
       controller: controller,
       style: TextStyle(
           color: color,
           fontSize: 16
       ),
       keyboardType:type ,
       obscureText: isPassword,
       onFieldSubmitted:(s){
         onSubmit!(s);
       },
       validator: (value) {
         return validate!(value);
       },
       enabled: isClickable,
       decoration: InputDecoration(
         labelText: label,
         labelStyle: TextStyle(
             color: color,
             fontSize: 15
         ) ,
         prefixIcon: Icon(
      prefix,
      color: color,),
    suffixIcon: suffix!= null ? IconButton(
      onPressed: () {
        suffixPressed!();
      },
      icon:Icon(suffix),color: iconColor,) : null ,
    border:OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius)
    ),

  ),



);

void NavigateTo(context,Widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder:(context) => Widget,
    )
);

Widget buildWeatherPage(weatherModel model,Forecastday forecastday,context,
    {isSearch = false})
{
  int now = DateTime.now().hour ;

  DateTime localtime = model.location!.localtime!;
  String formattedTime = DateFormat.jm().format(localtime);
  return Scaffold(
    body: Container(
      decoration: now >5&&now <18?
       BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/sunrise.jpg'),
          fit: BoxFit.cover,
        ),
      ):BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/afternoon.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 4.h,horizontal: 1.h),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            isSearch==false?
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: (){
                    NavigateTo(context, SearchScreen());
                  },
                  icon: Icon(Icons.search,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ],
            ):Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: (){
                    NavigateTo(context, HomePage());
                  },
                  icon: Icon(Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      isSearch==true?
                      Text('${SearchCubit.get(context).translation}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontSize: 27
                        ),
                      ):Text('${weatherCubit.get(context).translation}',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                            fontSize: 21
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: 80,
                  child: Text(
                    'updated ${formattedTime }',textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontSize: 9
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 4.h,),

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '  ${model.current!.tempC}',
                      style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 45,
                      ),
                    ),
                    Text('℃',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 22

                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "    ${forecastday.day!.maxtempC} / ${forecastday.day!.mintempC}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 12

                      ),
                    ),
                    Text('℃',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 12

                      ),
                    )
                  ]
                  ,),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    model.current!.condition!.text=="Sunny"?
                    Icon(
                      Icons.wb_sunny,
                      size: 30,
                      color: Colors.orange,
                    ):Icon(
                      Icons.wb_cloudy,
                      size: 24,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text("${model.current!.condition!.text}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 20
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            Container(
              height: 90.0,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) =>
                      buildhourItem(model.forecast!.forecastday[0].hour[index],context),
                  separatorBuilder: (context,index)=>SizedBox(width: 10,),
                  itemCount:model.forecast!.forecastday[0].hour.length),
            ),
            ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index) =>
                    builddayItem(model.forecast!.forecastday[index+1],context),
                separatorBuilder: (context,index)=>SizedBox(width: 10,),
                itemCount:model.forecast!.forecastday.length-1),
            SizedBox(height: 7.h,),

            ComfortItem(model.current!,context),




          ],
        ),
      ),
    ),
  );
}

Widget buildhourItem(Hour model,context)
{
  DateTime now = model.time!;
  String formattedTime = DateFormat.jm().format(now);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${formattedTime}",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
        model.condition!.text=="Sunny"?
        Icon(Icons.wb_sunny,
          color: Colors.orange,
        ):Icon(Icons.dark_mode_sharp,
          color: Colors.orange,
        ),
        Row(
          children: [
            Text("${model.tempC}",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white
              ),
            ),
            Text('℃',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 13

              ),
            )
          ],
        ),


      ],
    ),
  );
}

Widget builddayItem(Forecastday model,context)
{
  DateTime day = model.date!;
  String formattedDay = DateFormat('EEEE').format(day);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 1.h),
    child: Row(
      children: [
        Expanded(
          child: Text("${formattedDay}",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 20.0,
                color: Colors.white
            ),
          ),
        ),
        if (model.day!.condition!.text=="Sunny")
          Expanded(
            child: Icon(Icons.wb_sunny,
              color: Colors.orange,
            ),
          )
        else
          Expanded(
            child: Icon(Icons.cloud,
              color: Colors.white,
            ),
          ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                " ${model.day!.maxtempC}/${model.day!.mintempC}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 15

                ),
              ),
              Text('℃',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 12

                ),
              )
            ]
            ,),
        ),


      ],
    ),
  );
}

Widget ComfortItem(Current model,context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Humidity",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize:18.0,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 2.h,),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircularSeekBar(
                    width: 140,
                    height: 140,
                    progress: model.humidity!.toDouble(),
                    barWidth: 8,
                    startAngle: 45,
                    sweepAngle: 270,
                    strokeCap: StrokeCap.butt,
                    progressGradientColors: const [Colors.purple, Colors.indigo, Colors.blue],
                    dashWidth: 1,
                    dashGap: 2,
                    animation: true,
                    child: Center(
                      child: Text("${model.humidity}%",
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text("0",style: TextStyle(color: Colors.white),)),
                        Spacer(),
                        Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Text("100",style: TextStyle(color: Colors.white),))
                      ],
                    ),
                  )


                ],
              ),


            ],
          ),
        ),
        SizedBox(width: 10.h,),
        Center(
          child: Column(
            children: [
              Text("Feels Like: ${model.feelslike_c}℃",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize:12.0,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 1.h,),
              Text("UV index: ${model.uv} Low",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize:12.0,
                    color: Colors.white
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
