import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userapp/Home.dart';
import 'package:userapp/api/UserRepository.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    // on<LoginScreenEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<CheckLoginEvent>((event,emit)async{

      final SharedPreferences prefs= await SharedPreferences.getInstance();
      final String? studId= prefs.getString('studid');
      final String? pass=prefs.getString('pass');
      if(studId == null || pass==null)
        {
          emit(UserNotLoginedState());
        }
      else
        {
          emit(UserLoginedState( studId: studId,pass: pass));
        }

    });

    on<LoginUserEvent>((event,emit)async{
          try{
              String data=await UserRepository().loginUser(event.studid, event.pass);
              var dt=jsonDecode(data);
              print(dt);
              if(dt["success"]=true) {
                final SharedPreferences prefs = await SharedPreferences
                    .getInstance();
                prefs.setString("token", dt["token"]);
                UserRepository.token=dt["token"];
                prefs.setString("studid", event.studid);
                prefs.setString("pass", event.pass);
                prefs.setString("name", dt["student_details"]["fname"]+dt["student_details"]["lname"]);
                prefs.setString("mobile", dt["student_details"]["mob"]);

                Navigator.pushReplacement(event.context,MaterialPageRoute(builder: (context)=> HomeScreen()));
              }
              else
                {
                  emit(UserNotLoginedMessageState());
                  emit(UserNotLoginedState());
                }

          }catch(e)
      {
              print(e);
      }

    });


  }
}
