import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/app_resources/string_resources.dart';
import 'package:flutter_weather_app/db_connectivity/db_credentials.dart';

import '../app_resources/color_resources.dart';
import '../app_resources/font_resource.dart';
import '../app_resources/image_resource.dart';
import '../app_resources/routes_manager.dart';
import '../app_resources/value_resources.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(AppString.app_bar_title),),
      body:  _registerWidget(),
    );
  }
  Widget _registerWidget(){
    return  Padding(
      padding: EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p100, AppPadding.p8, AppPadding.p8),
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(height: AppSize.s100,
                ImageAsset.app_logo),
            SizedBox(height: AppSize.s10,),
            TextField(
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
                controller: _email,
                decoration: InputDecoration(
                  label: Text(AppString.email_lable_text, style: TextStyle(color: AppColor.primary),),
                  hintText: AppString.enter_email,
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
                  onPressed: (){
                    DBCredentials().insert(_name.text, _email.text, _password.text);
                  }, child: Text(AppString.register, style: TextStyle(color: AppColor.primary),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                      shape: MaterialStatePropertyAll(StadiumBorder(side: BorderSide(color: AppColor.orange, width: 1, style:  BorderStyle.solid)))),)
            ),
            SizedBox(height: AppSize.s10,),


            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, Routes.initRoute);
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
                      Text(AppString.already_have_account, style: TextStyle(fontSize: AppFont.fs12, fontWeight: AppFontWeight.semiBold),
                      ),
                      SizedBox(width: AppSize.s10,),
                      Text(AppString.login, style: TextStyle(fontSize: AppFont.fs12, fontWeight: AppFontWeight.semiBold, color: AppColor.primary),)
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
