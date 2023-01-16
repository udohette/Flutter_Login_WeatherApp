import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/app_resources/routes_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mysql1/mysql1.dart';

import '../app_resources/color_resources.dart';
import '../app_resources/font_resource.dart';
import '../app_resources/image_resource.dart';
import '../app_resources/string_resources.dart';
import '../app_resources/value_resources.dart';
import '../db_connectivity/db_credentials.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();

  String data = "";


  @override
  void initState() {
    getLocation();
    // just ot  log initial credentials
    _weatherLogin();
    super.initState();
  }
  void _weatherLogin()async{
    var name = _name.text;
    var password = _password.text;
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      port: 3306,
      user: "root",
      db: "weather_app",
    ));
    var user1 = 3;
    //var result = await conn.query('select name, password from users where id = ?', [user1]);
    var result = await conn.query('select name from users where name = ? and password = ?',[name.toString(), password.toString()]);
    print(result.affectedRows);
    print(result.insertId);
    print("result of the object  $result");

    if(result.isEmpty){
      setState(() {
        print("Result is Empty Error");
      });
    }else{
      Navigator.pushReplacementNamed(context, Routes.weatherRoute);
    }
    await conn.close();
    //DBCredentials().retrieve();
    print("Name Object $_name");
    print("Password Object $_password");

  }

  void getLocation()async{
    bool isServiceEnabled;
    LocationPermission locationPermission;
    //test if location Service are Enabled
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!isServiceEnabled){
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error("Location Service are not Enabled");
    }
    locationPermission  = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied){
      locationPermission = await Geolocator.requestPermission();

      if(locationPermission == LocationPermission.denied){
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error("Location Service are not Enabled");

      }
    }
    if(locationPermission == LocationPermission.deniedForever){
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    Position  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("Printing Location Current Position $position");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loginWidget(),
    );
  }

  Widget _loginWidget(){

    return  SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p100, AppPadding.p8, AppPadding.p8),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(height: AppSize.s100, ImageAsset.app_logo),
            SizedBox(height: AppSize.s10,),
            TextField(
              keyboardType: TextInputType.text,
              enableSuggestions: true,
              autofocus: true,
              autocorrect: true,
              enabled: true,
                style: TextStyle(fontSize: AppFont.fs14, color: AppColor.primary),
                controller: _name,
                decoration: InputDecoration(
                  label: Text(AppString.name_lable_text, style: TextStyle(color: AppColor.primary),),
                  hintText: AppString.enter_name,
                  hintStyle: TextStyle(color: AppColor.primary),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s20), borderSide: BorderSide(color: AppColor.orange)),
                  enabled: true,
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s20), borderSide: BorderSide(color: AppColor.orange)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s20), borderSide: BorderSide(color: AppColor.orange)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,  borderSide: BorderSide(color: AppColor.red),
                  ),
                )),
            SizedBox(height: AppSize.s10,),
            TextField(
                style: TextStyle(fontSize: AppSize.s14, color: AppColor.primary),
                controller: _password,
                decoration: InputDecoration(
                  label: Text(AppString.password_lable_text, style: TextStyle(color: AppColor.primary),),
                  hintText: AppString.enter_password,
                  hintStyle: TextStyle(color: AppColor.primary),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s20), borderSide: BorderSide(color: AppColor.orange)),
                  enabled: true,
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s20), borderSide: BorderSide(color: AppColor.orange)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s20), borderSide: BorderSide(color: AppColor.orange)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.zero,  borderSide: BorderSide(color: AppColor.red),
                  ),
                )
            ),
            SizedBox(height: AppSize.s10,),
            Container(
                height: AppSize.s50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async{
                    //Get the current location
                    getLocation();
                    _weatherLogin();
                  }, child: Text(AppString.login, style: TextStyle(color: AppColor.primary),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(StadiumBorder(side: BorderSide(color: AppColor.orange, width: 1, style:  BorderStyle.solid)))),)
            ),
            SizedBox(height: AppSize.s10,),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.registerRoute);
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(AppPadding.p14),
                margin: EdgeInsets.symmetric(vertical: AppMargin.m20),
                child: Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28,top: AppPadding.p8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppString.dont_have_account, style: TextStyle(fontSize: AppFont.fs12, fontWeight: AppFontWeight.semiBold),
                      ),
                      SizedBox(width: AppSize.s10,),
                      Text(AppString.register_new_user, style: TextStyle(fontSize: AppFont.fs12, fontWeight: AppFontWeight.semiBold, color: AppColor.primary),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
