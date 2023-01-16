




import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/app_resources/color_resources.dart';
import 'package:flutter_weather_app/app_resources/string_resources.dart';
import 'package:flutter_weather_app/app_resources/value_resources.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}


class _WeatherState extends State<Weather> {
  @override
  void initState() {
    weather_api();
    super.initState();
  }
  @override
  static const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  String apiKey = 'f30b6e465fef7cc830db70cae2623bf7';

  int temperature = 0;
  String condition = '';
  int humidity = 0;
  String country = '';
  String city = '';
  int feels = 0;
  double speed = 0.0;

   weather_api()async {
    double latitude;
    late double longitude;
    int status;
    try{
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;

      print("Latitude $latitude");
      print("Longitude $longitude");

      http.Response response = await http.get(Uri.parse('$weatherApiUrl?lat=$latitude&lon=$longitude&appid=$apiKey'));
      print('$weatherApiUrl?lat=$latitude&lon=$longitude&$apiKey');
      if(response.statusCode == 200){
        String data = response.body;
        double  temp = jsonDecode(data)['main']['temp'];
        double feels_temp = jsonDecode(data)['main']['feels_like'];
        print(jsonDecode(data));
        setState(() {
          condition = jsonDecode(data)['weather'][0]['main'];
          humidity = jsonDecode(data)['main']['humidity'];
          country = jsonDecode(data)['sys']['country'];
          speed = jsonDecode(data)['wind']['speed'];
          city = jsonDecode(data)['name'];
          temperature = temp.toInt();
          feels = feels_temp.toInt();
        });
      }else{
        print("Error code in processing Object ${response.statusCode}");
      }

    }catch(e){
      print("$e");
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(AppString.app_title),),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage("https://i.pinimg.com/736x/c3/40/37/c34037e4537544991bca11017f0d20e9.jpg"))
                ),
                child: BackdropFilter(
                  child: Container(color: Colors.black.withOpacity(0.1),),
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0)),
              )
          ),
          Positioned(child: SafeArea(
            child: Column(children: [
              Padding(padding: EdgeInsets.symmetric(horizontal: AppSize.s18, vertical: AppSize.s25),
                child: Row(children: [
                  SizedBox(width: AppSize.s8,),
                  Spacer(),
                  Icon(Icons.edit_location, color: AppColor.white, size: AppSize.s16,),
                  Text('$country', style: TextStyle(color: AppColor.white, fontSize: AppSize.s16),),
                  SizedBox(width: AppSize.s8,)
                ],
                ),
              ),
              Padding(padding: EdgeInsets.all(15.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: AppSize.s25,
                      width: AppSize.s100,
                    ),
                    Container(
                      height: AppSize.s120,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$temperature", style: TextStyle(color: AppColor.white, fontSize: AppSize.s64, fontWeight: FontWeight.bold),),
                                Text("Feels  Like $feels", style: TextStyle(color: AppColor.white, fontSize: AppSize.s16, fontWeight: FontWeight.bold),)
                            ],),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(100, 20, 0, 0),
                              child: Text("Speed  $speed", style: TextStyle(color: AppColor.white, fontSize: AppSize.s16, fontWeight: FontWeight.bold),),
                            )
                          ],
                          ),
                          VerticalDivider(color: AppColor.white,),
                          Column(children: [
                            Icon(Icons.cloud, color: AppColor.white, size: AppSize.s80,),
                            Text('$condition', style: TextStyle(color: AppColor.white),)
                          ],)

                      ],),
                    ),
                    Divider(color: AppColor.white,),
                    Text(city, style: TextStyle(color: AppColor.white),)
                  ],
                ),
              ),
              )
            ],),
          ))
        ],
      ),
    );
  }
}
